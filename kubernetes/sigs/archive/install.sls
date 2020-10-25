#  -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {%- if grains.os|lower != 'windows' %}

{{ formula }}-sigs-archive-deps-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}

    {%- endif %}
    {%- if 'wanted' in d.sigs and d.sigs.wanted %}
        {%- for tool in d.sigs.wanted|unique %}
            {%- if 'pkg' in d.sigs and tool in d.sigs['pkg'] and d.sigs['pkg'][tool] %}
                {%- set p = d.sigs['pkg'][tool] %}
                {%- if p['use_upstream'] == 'archive' and 'archive' in p %}

{{ formula }}-sigs-archive-{{ tool }}-install:
  file.directory:
    - name: {{ p['path'] }}
    - clean: {{ d.clean }}
    - makedirs: True
    - require_in:
      - archive: {{ formula }}-sigs-archive-{{ tool }}-install
                    {%- if grains.os|lower != 'windows' %}
    - require:
      - pkg: {{ formula }}-sigs-archive-deps-install
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
                    {%- if grains.os|lower != 'windows' %}

    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
                        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                            {%- for cmd in p['commands']|unique %}

{{ formula }}-sigs-archive-{{ tool }}-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ p['path'] }}/bin/{{ tool }}
    - force: True
    - onlyif:
      - test -f {{ p['path'] }}/bin/{{ tool }}
    - require:
      - archive: {{ formula }}-sigs-archive-{{ tool }}-install

                            {%- endfor %}
                        {%- endif %}
                    {%- elif tool in ('kind',) %}
  cmd.run:
    - name: mv {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }} {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }}.exe
    - onlyif: test -f {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }}

                    {%- endif %}
                {%- endif %}
            {%- endif %}
        {%- endfor %}
        {%- if grains.os|lower == 'windows' %}

{{ formula }}-sigs-archive-install-bashrc:
  file.replace:
    - name: C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - pattern: '^export PATH=${PATH}:/cygdrive/c/kubernetes/bin$'
    - repl: 'export PATH=${PATH}:/cygdrive/c/kubernetes/bin'
    - append_if_not_found: True
  cmd.run:
    - name: sed -i -e "s/\r//g" C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - onchanges:
      - file: {{ formula }}-sigs-archive-install-bashrc

        {%- endif %}
    {%- endif %}
