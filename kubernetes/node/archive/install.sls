# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {%- if d.node.pkg.use_upstream == 'archive' and 'archive' in d.node.pkg %}

kubernetes-node-archive-install:
        {%- if grains.os|lower != 'windows' %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: kubernetes-node-archive-install
        {%- endif %}
  file.directory:
    - name: {{ d.node.pkg.path }}
    - makedirs: True
    - clean: False   # don't
    - require_in:
      - archive: kubernetes-node-archive-install
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
    {{- format_kwargs(d.node['pkg']['archive']) }}
    - retry: {{ d.retry_option|json }}
    - enforce_toplevel: false
    - trim_output: true
    - force: true
    - overwrite: {{ d.overwrite }}
    - require:
      - file: kubernetes-node-archive-install
        {%- if grains.os|lower != 'windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
            {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                {%- for cmd in d.node.pkg.commands|unique %}

kubernetes-node-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.node.pkg.path }}/bin/{{ cmd }}
    - force: True
    - require:
      - archive: kubernetes-node-archive-install

                {%- endfor %}
            {%- endif %}
        {%- elif grains.os|lower == 'windows' %}

kubernetes-node-archive-install-bashrc:
  file.replace:
    - name: C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - pattern: '^export PATH=${PATH}:/cygdrive/c/kubernetes/bin$'
    - repl: 'export PATH=${PATH}:/cygdrive/c/kubernetes/bin'
    - append_if_not_found: True
  cmd.run:
    - name: sed -i -e "s/\r//g" C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - onchanges:
      - file: kubernetes-node-archive-install-bashrc

kubernetes-node-archive-install-windows-tidyup:
  cmd.run:
    - name: mv {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}*.exe {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }} || True
    - onlyif: test -d {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}
  file.absent:
    - names:
       - {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}bin
       - {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}owners
       - {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}vendors
       - {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}LICENSE

        {%- endif %}
    {%- endif %}
