# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
    {%- if 'wanted' in d.devtools and d.devtools.wanted %}
        {%- for tool in d.devtools.wanted|unique %}
            {%- set bin = '/bin' if d.devtools['pkg'][tool]['use_upstream'] == 'binary' else '' %}
            {%- if 'pkg' in d.devtools and tool in d.devtools['pkg'] and d.devtools['pkg'][tool] %}
                {%- for cmd in d.devtools['pkg'][tool]['commands']|unique %}

{{ formula }}-devtools-{{ tool }}-alternatives-clean-{{ bin }}-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-devtools-{{ tool }}-{{ cmd }}
    - path: {{ d.devtools['pkg'][tool]['path'] }}/{{ bin }}/{{ cmd }}
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-devtools-{{ tool }}-{{ cmd }}

                {%- endfor %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
{%- endif %}
