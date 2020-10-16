# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.operators and d.operators.wanted %}
        {%- for tool in d.operators.wanted|unique %}
            {%- if d.operators.pkg[tool]['use_upstream'] == 'archive' %}
                {%- if 'pkg' in d.operators and tool in d.operators['pkg'] and d.operators['pkg'][tool] %}

{{ formula }}-operators-archive-{{ tool }}-clean:
  file.absent:
    - names:
      - {{ d.operators['pkg'][tool]['path'] }}

                {% endif %}
            {% endif %}
        {%- endfor %}
    {%- endif %}
