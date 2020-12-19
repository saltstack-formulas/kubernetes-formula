#  -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {%- if grains.os != 'Windows' %}
kubernetes-operators-archive-deps-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    {%- endif %}

    {%- if 'wanted' in d.operators and d.operators.wanted %}
        {%- for tool in d.operators.wanted|unique %}
            {%- if 'pkg' in d.operators and tool in d.operators['pkg'] and d.operators.pkg[tool] %}
                {%- if d.operators.pkg[tool]['use_upstream'] == 'archive' and 'archive' in d.operators.pkg[tool] %}

kubernetes-operators-archive-{{ tool }}-install:
  file.directory:
    - name: {{ d.operators.pkg[tool]['path'] }}
    - clean: {{ d.clean }}
    - makedirs: True
    - require_in:
      - archive: kubernetes-operators-archive-{{ tool }}-install
                   {%- if grains.os != 'Windows' %}
    - require:
      - pkg: kubernetes-operators-archive-deps-install
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
                   {%- endif %}
  archive.extracted:
    {{- format_kwargs(d.operators.pkg[tool]['archive']) }}
    - retry: {{ d.retry_option }}
    - enforce_toplevel: false
    - trim_output: true
                   {%- if grains.os != 'Windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
                   {%- endif %}

                {% endif %}
            {% endif %}
        {%- endfor %}
    {%- endif %}
