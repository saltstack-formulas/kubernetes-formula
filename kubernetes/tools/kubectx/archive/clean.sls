# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- set sls_alternatives_clean = tplroot ~ '.kubectx.archive.alternatives.clean' %}

include:
  - {{ sls_alternatives_clean }}

{{ formula }}-tools-kubectx-archive-absent:
  file.absent:
    - names:
      - {{ d.dir.tmp }}/kubectx*
      - {{ d.kubectx.pkg.archive.name }}
        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.kubectx.pkg.commands %}
      - /usr/local/bin/{{ cmd }}
            {%- endfor %}
        {%- endif %}
