# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- if 'wanted' in d.sigs and d.sigs.wanted %}
            {%- for tool in d.sigs.wanted|unique %}
                {%- if 'pkg' in d.sigs and tool in d.sigs['pkg'] and d.sigs['pkg'][tool] %}
                    {%- for cmd in d.sigs['pkg'][tool]['commands']|unique %}

kubernetes-sigs-{{ tool }}-alternatives-clean-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-sigs-{{ tool }}-{{ cmd }}
    - path: {{ d.sigs['pkg'][tool]['path'] }}/{{ cmd }}
    - onlyif:
      - update-alternatives --list |grep ^link-k8s-sigs-{{ tool }}-{{ cmd }}

                    {%- endfor %}
                {%- endif %}
            {%- endfor %}
        {%- endif %}
    {%- endif %}
