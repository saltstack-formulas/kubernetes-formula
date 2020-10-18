#  -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {%- if 'wanted' in d.devlibs and d.devlibs.wanted %}

        {%- if grains.os != 'Windows' %}
{{ formula }}-devlibs-pkg-deps-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
        {%- endif %}

        {%- for tool in d.devlibs.wanted|unique %}
            {%- if 'pkg' in d.devlibs and tool in d.devlibs['pkg'] and d.devlibs['pkg'][tool] %}
                {%- set p = d.devlibs.pkg[tool] %}
                {%- if p['use_upstream'] == 'archive' and 'archive' in p %}

{{ formula }}-devlibs-archive-{{ tool }}-install:
  file.directory:
    - name: {{ p['path'] }}
    - clean: {{ d.clean }}
    - makedirs: True
    - require_in:
      - archive: {{ formula }}-devlibs-archive-{{ tool }}-install
                   {%- if grains.os != 'Windows' %}
    - require:
      - pkg: {{ formula }}-devlibs-pkg-deps-install
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
                   {%- endif %}
  archive.extracted:
    {{- format_kwargs(p['archive']) }}
    - retry: {{ d.retry_option }}
    - enforce_toplevel: false
    - trim_output: true
                   {%- if grains.os != 'Windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
                   {%- endif %}
                {% endif %}
            {% endif %}
        {%- endfor %}
    {%- endif %}
