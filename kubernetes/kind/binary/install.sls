# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-kind-binary-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
  file.directory:
    - name: {{ d.kind.pkg.binary.name }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-kind-binary-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ d.kind.pkg.binary.name }}/bin/kind {{ d.kind.pkg.binary.source }}
      - chmod '0755' {{ d.kind.pkg.binary.name }}/bin/kind 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
      {%- if 'source_hash' in d.kind.pkg.binary and d.kind.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ d.kind.pkg.binary.name }}/bin/kind
    - file_hash: {{ d.kind.pkg.binary.source_hash }}
    - require:
      - cmd: {{ formula }}-kind-binary-install
      {%- endif %}

{{ formula }}-kind-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/kind
    - target: {{ d.kind.pkg.binary.name }}/bin/{{ d.kind.pkg.name }}
    - force: True
    - require:
      - cmd: {{ formula }}-kind-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}
