# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-devspace-binary-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
  file.directory:
    - name: {{ d.devspace.pkg.binary.name }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-devspace-binary-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ d.devspace.pkg.binary.name }}/bin/devspace {{ d.devspace.pkg.binary.source }}
      - chmod '0755' {{ d.devspace.pkg.binary.name }}/bin/devspace 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
      {%- if 'source_hash' in d.devspace.pkg.binary and d.devspace.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ d.devspace.pkg.binary.name }}/bin/devspace
    - file_hash: {{ d.devspace.pkg.binary.source_hash }}
    - require:
      - cmd: {{ formula }}-devspace-binary-install
      {%- endif %}

{{ formula }}-devspace-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/devspace
    - target: {{ d.devspace.pkg.binary.name }}/bin/{{ d.devspace.pkg.name }}
    - force: True
    - require:
      - cmd: {{ formula }}-devspace-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}
