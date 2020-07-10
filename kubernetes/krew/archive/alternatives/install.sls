# -*- coding: utf-8 -*-
# vim: ft=sls

{%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}
    {%- set tplroot = tpldir.split('/')[0] %}
    {%- from tplroot ~ "/map.jinja" import data as d with context %}
    {%- set formula = d.formula %}

    {%- if d.krew.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}
        {%- set sls_archive_install = tplroot ~ '.krew.archive.install' %}
include:
  - {{ sls_archive_install }}

{{ formula }}-krew-archive-alternatives-install:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-krew
    - link: /usr/local/bin/krew
    - path: {{ d.krew.pkg.archive.name }}/bin/krew
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_archive_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/krew link-k8s-krew {{ d.krew.pkg.archive.name }}/bin/krew {{ d.linux.altpriority }} # noqa 204

{{ formula }}-krew-archive-alternatives-set:
  alternatives.set:
    - unless:
      # {{ grains.os in ('Debian',) }}
      - {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-krew
    - path: {{ d.krew.pkg.archive.name }}/bin/krew
    - require:
      - alternatives: {{ formula }}-krew-archive-alternatives-install
      - sls: {{ sls_archive_install }}

    {%- endif %}
{%- endif %}
