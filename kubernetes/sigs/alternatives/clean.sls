# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
    {%- if 'wanted' in d.sigs and d.sigs.wanted %}
        {%- for tool in d.sigs.wanted|unique %}
            {%- set bin = '/bin' if d.sigs['pkg'][tool]['use_upstream'] == 'binary' else '' %}
            {%- if 'pkg' in d.sigs and tool in d.sigs['pkg'] and d.sigs['pkg'][tool] %}
                {%- for cmd in d.sigs['pkg'][tool]['commands']|unique %}

{{ formula }}-sigs-{{ tool }}-alternatives-clean-{{ bin }}-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-sigs-{{ tool }}-{{ cmd }}
    - path: {{ d.sigs['pkg'][tool]['path'] }}/{{ bin }}/{{ cmd }}
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-sigs-{{ tool }}-{{ cmd }}

                {%- endfor %}
            {%- endif %}

        {%- endfor %}
    {%- endif %}
{%- endif %}
