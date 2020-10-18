# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.devtools and d.devtools.wanted %}
        {%- for tool in d.devtools.wanted|unique %}
            {%- if 'pkg' in d.devtools and tool in d.devtools['pkg'] and d.devtools.pkg[tool] %}

{{ formula }}-devtools-archive-{{ tool }}-clean:
  file.absent:
    - names:
      - "{{ d.devtools['pkg'][tool]['path'] }}"
                {%- for cmd in d.devtools['pkg'][tool]['commands']|unique %}
      - /usr/local/bin/{{ cmd }}
                {%- endfor %}
  module.run:
    - name: file.find
    - path: "{{ d.dir.base }}"
    - kwargs:
        iname: "k8s-devtools-{{ tool }}*"
        delete: "d"

            {% endif %}
        {%- endfor %}
    {%- endif %}
