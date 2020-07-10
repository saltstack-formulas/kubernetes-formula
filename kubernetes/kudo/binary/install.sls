# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-kudo-binary-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
  file.directory:
    - name: {{ d.kudo.pkg.binary.name }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-kudo-binary-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ d.kudo.pkg.binary.name }}/bin/kubectl-kudo {{ d.kudo.pkg.binary.source }}
      - chmod '0755' {{ d.kudo.pkg.binary.name }}/bin/kubectl-kudo 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
      {%- if 'source_hash' in d.kudo.pkg.binary and d.kudo.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ d.kudo.pkg.binary.name }}/bin/kubectl-kudo
    - file_hash: {{ d.kudo.pkg.binary.source_hash }}
    - require:
      - cmd: {{ formula }}-kudo-binary-install
      {%- endif %}

{{ formula }}-kudo-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/kubectl-kudo
    - target: {{ d.kudo.pkg.binary.name }}/bin/kubectl-kudo
    - force: True
    - require:
      - cmd: {{ formula }}-kudo-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}
