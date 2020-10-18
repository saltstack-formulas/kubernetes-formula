# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.devlibs and d.devlibs.wanted %}
        {%- for tool in d.devlibs.wanted|unique %}
            {%- if 'pkg' in d.devlibs and tool in d.devlibs['pkg'] and d.devlibs['pkg'][tool] %}

{{ formula }}-devlibs-archive-{{ tool }}-clean:
  file.absent:
    - names:
      - {{ d.devlibs['pkg'][tool]['path'] }}

            {% endif %}
        {%- endfor %}
    {%- endif %}
