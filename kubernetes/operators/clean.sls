# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.operators and d.operators.wanted %}
        {%- for operator in d.operators.wanted %}
            {%- if 'pkg' in d.operators and d.operators['pkg'] %}

{{ formula }}-operators-clean-{{ operator }}:
  file.absent:
    - name: {{ d.dir.source }}/{{ operator }}

            {% endif %}
        {% endfor %}
    {% endif %}
