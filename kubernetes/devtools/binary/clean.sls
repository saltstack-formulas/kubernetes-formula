# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if 'wanted' in d.devtools and d.devtools.wanted %}
    {%- for tool in d.devtools.wanted|unique %}
        {%- if d.devtools.pkg[tool]['use_upstream'] == 'binary' %}
            {%- if 'pkg' in d.devtools and tool in d.devtools['pkg'] and d.devtools['pkg'][tool] %}

{{ formula }}-devtools-binary-{{ tool }}-clean:
  file.absent:
    - names:
      - {{ d.devtools['pkg'][tool]['path'] }}/{{ tool }}
                {%- for cmd in d.devtools['pkg'][tool]['commands']|unique %}
      - /usr/local/bin/{{ cmd }}
                {%- endfor %}

            {% endif %}
        {% endif %}
    {%- endfor %}
{%- endif %}
