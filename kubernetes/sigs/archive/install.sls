#  -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-sigs-archive-deps-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}

{%- if 'wanted' in d.sigs and d.sigs.wanted %}
    {%- for tool in d.sigs.wanted|unique %}
        {%- if 'pkg' in d.sigs and tool in d.sigs['pkg'] and d.sigs['pkg'][tool] %}
            {%- set p = d.sigs['pkg'][tool] %}
            {%- if p['use_upstream'] == 'archive' and 'archive' in p %}

{{ formula }}-sigs-archive-{{ tool }}-install:
  file.directory:
    - name: {{ p['path'] }}
    - mode: 755
    - clean: True
    - makedirs: True
    - require:
      - pkg: {{ formula }}-sigs-archive-deps-install
    - require_in:
      - archive: {{ formula }}-sigs-archive-{{ tool }}-install
                {%- if grains.os != 'Windows' %}
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
                {%- endif %}
                {%- if (d.linux.altpriority|int == 0 and grain.os != 'Windows') or grains.os_family in ('Arch', 'MacOS') %}
                    {%- for cmd in p['commands']|unique %}

{{ formula }}-sigs-archive-{{ tool }}-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ p['path'] }}/{{ tool }}
    - force: True
    - onlyif: test -f {{ p['path'] }}/{{ tool }}
    - require:
      - archive: {{ formula }}-sigs-archive-{{ tool }}-install

                    {% endfor %}
                {% endif %}

            {% endif %}
        {% endif %}
    {%- endfor %}
{%- endif %}
