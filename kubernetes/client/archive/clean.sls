# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- set sls_alternatives_clean = tplroot ~ '.client.archive.alternatives.clean' %}

include:
  - {{ sls_alternatives_clean }}

{{ formula }}-client-archive-absent:
  file.absent:
    - names:
      - {{ d.dir.tmp }}/client*
      - {{ d.client.pkg.archive.name }}/bin
        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.client.pkg.commands|unique %}
      - /usr/local/bin/{{ cmd }}
            {%- endfor %}
        {%- endif %}
