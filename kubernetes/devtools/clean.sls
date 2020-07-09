# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.devtools and d.devtools.wanted %}
        {%- for tool in d.devtools.wanted %}
            {%- if tool in d.devtools and d.devtools[tool] %}

{{ formula }}-devtools-{{ tool }}-archive-clean:
  file.absent:
    - names:
      - {{ d.devtools[tool]['pkg']['archive']['path'] }}
                {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                    {%- for cmd in d.devtools[tool]['pkg']['commands'] %}
      - /usr/local/bin/{{ cmd }}
                    {%- endfor %}
                {%- endif %}

            {% endif %}
        {%- endfor %}
    {%- endif %}
