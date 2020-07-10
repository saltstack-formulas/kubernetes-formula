# -*- coding: utf-8 -*-
# vim: ft=sls

{%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}
    {%- set tplroot = tpldir.split('/')[0] %}
    {%- from tplroot ~ "/map.jinja" import data as d with context %}
    {%- set formula = d.formula %}
    {%- set sls_archive_clean = tplroot ~ '.devtools.clean' %}

include:
  - {{ sls_archive_clean }}

    {%- if 'wanted' in d.devtools and d.devtools.wanted %}
        {%- for tool in d.devtools.wanted|unique %}
            {%- if 'pkg' in d.devtools and tool in d.devtools['pkg'] and d.devtools['pkg'][tool] %}
                {%- if d.devtools['pkg'][tool]['use_upstream_archive'] and d.linux.altpriority|int > 0 %}
                    {%- for cmd in d.devtools['pkg'][tool]['commands']|unique %}

{{ formula }}-devtools-{{ tool }}-archive-alternatives-clean-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-devtools-{{ tool }}-{{ cmd }}
    - path: {{ d.devtools['pkg'][tool]['archive']['name'] }}/{{ cmd }}
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-devtools-{{ tool }}-{{ cmd }}
    - require:
      - sls: {{ sls_archive_clean }}

                    {%- endfor %}
                {%- endif %}
            {%- endif %}

        {%- endfor %}
    {%- endif %}
{%- endif %}
