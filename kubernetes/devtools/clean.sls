# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.devtools and d.devtools.wanted %}
        {%- for tool in d.devtools.wanted %}
            {%- if 'pkg' in d.devtools and tool in d.devtools['pkg'] and d.devtools['pkg'][tool] %}

{{ formula }}-devtools-{{ tool }}-archive-clean:
  file.absent:
    - names:
      - {{ d.devtools['pkg'][tool]['archive']['name'] }}
                {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                    {%- for cmd in d.devtools['pkg'][tool]['commands'] %}
      - /usr/local/bin/{{ cmd }}
                    {%- endfor %}
                {%- endif %}

            {% endif %}
        {%- endfor %}
    {%- endif %}
