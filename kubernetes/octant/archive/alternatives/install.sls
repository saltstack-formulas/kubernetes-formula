# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}
        {%- if d.octant.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}

include:
  - {{ sls_archive_install }}

{{ formula }}-octant-archive-alternatives-install:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-octant
    - link: /usr/local/bin/octant
    - path: {{ d.octant.pkg.archive.name }}/octant
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_archive_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/octant link-k8s-octant {{ d.octant.pkg.archive.name }}/octant {{ d.linux.altpriority }} # noqa 204

{{ formula }}-octant-archive-alternatives-set:
  alternatives.set:
    - unless:
      # {{ grains.os in ('Debian',) }}
      - {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-octant
    - path: {{ d.octant.pkg.archive.name }}/octant
    - require:
      - alternatives: {{ formula }}-octant-archive-alternatives-install
      - sls: {{ sls_archive_install }}

        {%- endif %}
    {%- endif %}
