# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}
        {%- if d.octant.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}

include:
  - {{ sls_archive_clean }}

{{ formula }}-octant-archive-alternatives-remove:
  alternatives.remove:
    - name: link-k8s-octant
    - path: {{ d.octant.pkg.archive.name }}/octant
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-octant
    - require:
      - sls: {{ sls_archive_clean }}
    - unless:
      - {{ grains.os_family in ('Arch',) }}

        {%- endif %}
    {%- endif %}
