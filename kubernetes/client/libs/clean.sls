# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.client.libs and d.client.libs.wanted %}
        {%- for lib in d.client.libs.wanted %}
            {%- if 'libs' in d.client and lib in d.client.libs and d.client.libs[lib] %}

{{ formula }}-client-libs-clean-{{ lib }}:
  file.absent:
    - name: {{ d.dir.source }}/{{ lib }}

            {% endif %}
        {% endfor %}
    {% endif %}
