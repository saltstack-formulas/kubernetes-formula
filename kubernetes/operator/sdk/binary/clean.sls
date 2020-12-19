# -*- coding: utf-8 -*-
# vim: ft=sls

{%- if grains.kernel|lower in ('linux', 'darwin') %}

    {%- set tplroot = tpldir.split('/')[0] %}
    {%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if 'wanted' in d.operator.sdk and d.operator.sdk.wanted %}
        {%- for item in d.operator.sdk.wanted|unique %}
            {%- if d.operator.sdk.pkg[item]['use_upstream'] == 'binary' %}
                {%- set p = d.operator.sdk['pkg'] %}
                {%- if item in p and 'binary' in p[item] and 'source' in p[item]['binary'] %}

kubernetes-operator-sdk-binary-{{ item }}-clean:
  file.absent:
    - name: {{ p[item]['path'] }}/{{ item }}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
{%- endif %}
