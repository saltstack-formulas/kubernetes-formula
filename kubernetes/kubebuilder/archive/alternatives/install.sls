# -*- coding: utf-8 -*-
# vim: ft=sls

{%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}
    {%- set tplroot = tpldir.split('/')[0] %}
    {%- from tplroot ~ "/map.jinja" import data as d with context %}
    {%- set formula = d.formula %}

    {%- if d.kubebuilder.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}
        {%- set sls_archive_install = tplroot ~ '.kubebuilder.archive.install' %}
include:
  - {{ sls_archive_install }}

{{ formula }}-kubebuilder-archive-alternatives-install:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-kubebuilder
    - link: /usr/local/bin/kubebuilder
    - path: {{ d.kubebuilder.pkg.archive.name }}/bin/kubebuilder
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_archive_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/kubebuilder link-k8s-kubebuilder {{ d.kubebuilder.pkg.archive.name }}/bin/kubebuilder {{ d.linux.altpriority }} # noqa 204

{{ formula }}-kubebuilder-archive-alternatives-set:
  alternatives.set:
    - unless:
      # {{ grains.os in ('Debian',) }}
      - {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-kubebuilder
    - path: {{ d.kubebuilder.pkg.archive.name }}/bin/kubebuilder
    - require:
      - alternatives: {{ formula }}-kubebuilder-archive-alternatives-install
      - sls: {{ sls_archive_install }}

    {%- endif %}
{%- endif %}
