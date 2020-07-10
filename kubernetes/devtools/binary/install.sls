# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-devtools-stern-binary-install:
  file.directory:
    - name: {{ d.devtools.stern.pkg.binary.name }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-devtools-stern-binary-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ d.devtools.stern.pkg.binary.name }}/bin/stern {{ d.stern.pkg.binary.source }}
      - chmod '0755' {{ d.devtools.stern.pkg.binary.name }}/bin/stern 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
      {%- if 'source_hash' in d.devtools.stern.pkg.binary and d.stern.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ d.devtools.stern.pkg.binary.name }}/bin/stern
    - file_hash: {{ d.devtools.stern.pkg.binary.source_hash }}
    - require:
      - cmd: {{ formula }}-devtools-stern-binary-install
      {%- endif %}

{{ formula }}-devtools-stern-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/stern
    - target: {{ d.devtools.stern.pkg.binary.name }}/bin/stern
    - force: True
    - require:
      - cmd: {{ formula }}-devtools-stern-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}
