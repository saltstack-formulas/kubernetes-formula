# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.client.pkg.use_upstream == 'binary' %}

kubernetes-client-binary-install:
        {%- if grains.os|lower != 'windows' %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: kubernetes-client-binary-install
        {%- endif %}
  file.managed:
    - name: {{ d.client.pkg.path }}
    - source: {{ d.client.pkg.binary.source }}
        {%- if 'source_hash' in d.client.pkg.binary and d.client.pkg.binary.source_hash %}
    - source_hash: {{ p[tool]['binary']['source_hash'] }}
        {%- else %}
    - skip_verify: True
        {%- endif %}
    - makedirs: True
    - retry: {{ d.retry_option|json }}
        {%- if grains.os|lower != 'windows' %}
    - mode: '0755'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}

kubernetes-client-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/kubectl
    - target: {{ d.client.pkg.path }}/bin/kubectl
    - force: True
    - require:
      - cmd: kubernetes-client-binary-install
    - unless: {{ d.linux.altpriority|int > 0 }} || false

        {%- elif grains.os|lower == 'windows' %}

kubernetes-client-binary-install-bashrc:
  file.replace:
    - name: C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - pattern: '^export PATH=${PATH}:/cygdrive/c/kubernetes/bin$'
    - repl: 'export PATH=${PATH}:/cygdrive/c/kubernetes/bin'
    - append_if_not_found: True
  cmd.run:
    - name: sed -i -e "s/\r//g" C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - onchanges:
      - file: kubernetes-client-binary-install-bashrc

        {%- endif %}
    {%- endif %}
