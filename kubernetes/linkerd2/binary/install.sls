# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-linkerd2-binary-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
  file.directory:
    - name: {{ d.linkerd2.pkg.binary.name }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-linkerd2-binary-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ d.linkerd2.pkg.binary.name }}/bin/linkerd {{ d.linkerd2.pkg.binary.source }}
      - chmod '0755' {{ d.linkerd2.pkg.binary.name }}/bin/linkerd 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
      {%- if 'source_hash' in d.linkerd2.pkg.binary and d.linkerd2.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ d.linkerd2.pkg.binary.name }}/bin/linkerd
    - file_hash: {{ d.linkerd2.pkg.binary.source_hash }}
    - require:
      - cmd: {{ formula }}-linkerd2-binary-install
      {%- endif %}

{{ formula }}-linkerd2-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/linkerd
    - target: {{ d.linkerd2.pkg.binary.name }}/bin/linkerd
    - force: True
    - require:
      - cmd: {{ formula }}-linkerd2-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
