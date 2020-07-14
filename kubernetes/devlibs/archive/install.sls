#  -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{%- if 'wanted' in d.devlibs and d.devlibs.wanted %}
    {%- for tool in d.devlibs.wanted|unique %}
        {%- if 'pkg' in d.devlibs and tool in d.devlibs['pkg'] and d.devlibs['pkg'][tool] %}
            {%- set p = d.devlibs.pkg[tool] %}
            {%- if p['use_upstream'] == 'archive' and 'archive' in p %}

{{ formula }}-devlibs-archive-{{ tool }}-install:
  file.directory:
    - name: {{ p['path'] }}/
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - clean: True
    - makedirs: True
    - require_in:
      - archive: {{ formula }}-devlibs-archive-{{ tool }}-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(p['archive']) }}
    - retry: {{ d.retry_option }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - enforce_toplevel: false
    - trim_output: true
    - recurse:
        - user
        - group

            {% endif %}
        {% endif %}
    {%- endfor %}
{%- endif %}
