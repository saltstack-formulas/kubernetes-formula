# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

        {%- if not d.devspace.pkg.use_upstream_repo and d.linux.altpriority|int > 0 %}
            {%- set sls_binary_install = tplroot ~ '.devspace.binary.install' %}

include:
  {{ sls_binary_install }}

{{ formula }}-devspace-config-alternatives-install:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ d.devspace.pkg.use_upstream_repo }}
    - name: link-k8s-devspace
    - link: /usr/local/bin/devspace
    - path: {{ d.devspace.pkg.binary.name }}/bin/devspace
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_binary_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/devspace link-k8s-devspace {{ d.devspace.pkg.binary.name }}/bin/devspace {{ d.linux.altpriority }} # noqa 204

{{ formula }}-devspace-config-alternatives-set:
  alternatives.set:
    - unless:
      # {{ grains.os in ('Debian',) }}
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ d.devspace.pkg.use_upstream_repo }}
    - name: link-k8s-devspace
    - path: {{ d.devspace.pkg.binary.name }}/bin/devspace
    - require:
      - alternatives: {{ formula }}-devspace-config-alternatives-install
      - sls: {{ sls_binary_install }}

        {%- endif %}
    {%- endif %}
