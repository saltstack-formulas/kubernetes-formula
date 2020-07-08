# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-client-binary-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
  file.directory:
    - name: {{ d.client.pkg.binary.name }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-client-binary-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ d.client.pkg.binary.name }}/bin/kubectl {{ d.client.pkg.binary.source }}
      - chmod '0755' {{ d.client.pkg.binary.name }}/bin/kubectl 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
      {%- if 'source_hash' in d.client.pkg.binary and d.client.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ d.client.pkg.binary.name }}/bin/kubectl
    - file_hash: {{ d.client.pkg.binary.source_hash }}
    - require:
      - cmd: {{ formula }}-client-binary-install
      {%- endif %}

{{ formula }}-client-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/kubectl
    - target: {{ d.client.pkg.binary.name }}/bin/kubectl
    - force: True
    - require:
      - cmd: {{ formula }}-client-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}
