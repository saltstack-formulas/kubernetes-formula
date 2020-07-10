# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-skaffold-binary-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
  file.directory:
    - name: {{ d.skaffold.pkg.binary.name }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-skaffold-binary-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ d.skaffold.pkg.binary.name }}/bin/skaffold {{ d.skaffold.pkg.binary.source }}
      - chmod '0755' {{ d.skaffold.pkg.binary.name }}/bin/skaffold 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
      {%- if 'source_hash' in d.skaffold.pkg.binary and d.skaffold.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ d.skaffold.pkg.binary.name }}/bin/skaffold
    - file_hash: {{ d.skaffold.pkg.binary.source_hash }}
    - require:
      - cmd: {{ formula }}-skaffold-binary-install
      {%- endif %}

{{ formula }}-skaffold-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/skaffold
    - target: {{ d.skaffold.pkg.binary.name }}/bin/skaffold
    - force: True
    - require:
      - cmd: {{ formula }}-skaffold-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}
