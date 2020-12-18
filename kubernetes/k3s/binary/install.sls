# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.k3s.pkg.use_upstream == 'binary' %}

kubernetes-k3s-binary-install:
        {%- if grains.os|lower != 'windows' %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: kubernetes-k3s-binary-install
        {%- endif %}
  file.managed:
    - name: {{ d.k3s.pkg.path }}k3s
    - source: {{ d.k3s.pkg.binary.source }}
    - source_hash: {{ d.k3s.pkg.binary.source_hash }}
    - makedirs: True
    - retry: {{ d.retry_option|json }}
        {%- if grains.os|lower != 'windows' %}
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}

            {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                {%- for cmd in d.k3s.pkg['commands']|unique %}

kubernetes-k3s-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/k3s
    - target: {{ d.k3s.pkg.path }}/k3s
    - force: True
    - require:
      - file: kubernetes-k3s-binary-install
    - unless: {{ d.linux.altpriority|int > 0 }} || false

                {%- endfor %}
            {%- endif %}
        {%- elif grains.os|lower == 'windows' %}

  cmd.run:
    - name: mv {{ d.k3s.pkg.path }}k3s {{ d.k3s.pkg.path }}k3s.exe
    - onlyif: test -f {{ d.k3s.pkg.path }}k3s

kubernetes-k3s-archive-install-bashrc:
  file.replace:
    - name: C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - pattern: '^export PATH=${PATH}:/cygdrive/c/kubernetes/bin$'
    - repl: 'export PATH=${PATH}:/cygdrive/c/kubernetes/bin'
    - append_if_not_found: True
  cmd.run:
    - name: sed -i -e "s/\r//g" C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - onchanges:
      - file: kubernetes-k3s-archive-install-bashrc

        {%- endif %}
    {%- endif %}
