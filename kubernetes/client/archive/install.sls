# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if grains.kernel|lower in ('linux', 'darwin', 'windows') %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}
        {%- if d.client.pkg.use_upstream == 'archive' and 'pkg' in d.client and 'archive' in d.client['pkg'] %}

kubernetes-client-archive-install:
            {%- if grains.os|lower != 'windows' %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: kubernetes-client-archive-install
            {%- endif %}
  file.directory:
    - name: {{ d.client.pkg.path }}
    - makedirs: True
    - clean: {{ d.clean }}
    - require_in:
      - archive: kubernetes-client-archive-install
            {%- if grains.os|lower != 'windows' %}
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
            {%- endif %}
  archive.extracted:
    {{- format_kwargs(d.client['pkg']['archive']) }}
    - retry: {{ d.retry_option|json }}
    - enforce_toplevel: false
    - trim_output: true
    - force: true
    - require:
      - file: kubernetes-client-archive-install
            {%- if grains.os|lower != 'windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group

                {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                    {%- for cmd in d.client.pkg.commands|unique %}

kubernetes-client-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.client.pkg.path }}/bin/{{ cmd }}
    - force: True
    - onlyif: test -x {{ d.client.pkg.path }}/bin/{{ cmd }}
    - require:
      - archive: kubernetes-client-archive-install

                    {%- endfor %}
                {%- endif %}
            {%- endif %}
            {%- if grains.os|lower == 'windows' %}

kubernetes-client-archive-install-bashrc:
  file.replace:
    - name: C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - pattern: '^export PATH=${PATH}:/cygdrive/c/kubernetes/bin$'
    - repl: 'export PATH=${PATH}:/cygdrive/c/kubernetes/bin'
    - append_if_not_found: True
  cmd.run:
    - name: sed -i -e "s/\r//g" C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - onchanges:
      - file: kubernetes-client-archive-install-bashrc

            {%- endif %}
        {%- endif %}
    {%- else %}

kubernetes-client-archive-install-other:
  test.show_notification:
    - text: |
        The client archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
