# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.devtools and d.devtools.wanted %}
        {%- for tool in d.devtools.wanted %}
            {%- if 'pkg' in d.devtools and tool in d.devtools['pkg'] %}
                {%- if 'binary' in d.devtools['pkg'][tool] %}

{{ formula }}-devtools-{{ tool }}-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/{{ tool }}
      - {{ d.devtools['pkg'][tool]['binary']['name'] }}/bin/{{ tool }}

                {% endif %}
            {% endif %}
        {%- endfor %}
    {%- endif %}
