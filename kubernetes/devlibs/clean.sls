# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if 'wanted' in d.devlibs and d.devlibs.wanted %}
    {%- for lib in d.devlibs.wanted|unique %}

{{ formula }}-devlibs-clean-{{ lib }}:
  file.absent:
    - name: {{ d.dir.source }}/{{ lib }}

    {% endfor %}
{% endif %}
