#  -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{%- if 'wanted' in d.devtools and d.devtools.wanted %}
    {%- for tool in d.devtools.wanted|unique %}
        {%- if 'pkg' in d.devtools and tool in d.devtools['pkg'] and d.devtools['pkg'][tool] %}
            {%- set p = d.devtools.pkg[tool] %}
            {%- if p['use_upstream'] == 'archive' and 'archive' in p %}

{{ formula }}-devtools-archive-{{ tool }}-install:
  file.directory:
    - name: {{ d.devtools['pkg'][tool]['path'] }}/
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - clean: True
    - makedirs: True
    - require_in:
      - archive: {{ formula }}-devtools-archive-{{ tool }}-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(d.devtools['pkg'][tool]['archive']) }}
    - retry: {{ d.retry_option }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - enforce_toplevel: false
    - trim_output: true
    - recurse:
        - user
        - group
                {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                    {%- for cmd in d.devtools['pkg'][tool]['commands']|unique %}

{{ formula }}-devtools-archive-{{ tool }}-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.devtools['pkg'][tool]['path'] }}/{{ tool }}
    - force: True
    - onlyif: test -f {{ d.devtools['pkg'][tool]['path'] }}/{{ tool }}
    - require:
      - archive: {{ formula }}-devtools-archive-{{ tool }}-install

                    {% endfor %}
                {% endif %}

            {% endif %}
        {% endif %}
    {%- endfor %}
{%- endif %}
