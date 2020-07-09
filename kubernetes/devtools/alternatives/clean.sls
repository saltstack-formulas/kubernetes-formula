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
        {%- for tool in d.devtools.wanted %}
            {%- if tool in d.devtools and d.devtools[tool] %}
                {%- if d.devtools[tool]['pkg']['use_upstream_archive'] and d.linux.altpriority|int > 0 %}
                    {%- for cmd in d.devtools[tool]['pkg']['commands'] %}

{{ formula }}-devtools-{{ tool }}-archive-alternatives-clean-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-devtools-{{ tool }}-{{ cmd }}
    - path: {{ d.devtools[tool]['pkg']['archive']['path'] }}/{{ cmd }}
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-devtools-{{ tool }}-{{ cmd }}
    - require:
      - sls: {{ sls_archive_clean }}

                    {%- endfor %}
                {%- endif %}
            {%- endif %}

        {%- endfor %}
    {%- endif %}
{%- endif %}
