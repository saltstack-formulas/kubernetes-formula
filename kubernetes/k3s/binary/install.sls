# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-k3s-binary-prerequisites:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
  file.directory:
    - name: {{ d.k3s.pkg.binary.name }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - recurse:
        - user
        - group
        - mode
    - require:
      - pkg: {{ formula }}-k3s-binary-prerequisites

{{ formula }}-k3s-binary-install:
  file.managed:
    - name: {{ d.k3s.pkg.binary.name }}/bin/k3s
    - source: {{ d.k3s.pkg.binary.source }}
    - source_hash: {{ d.k3s.pkg.binary.source_hash }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - retry: {{ d.retry_option|json }}
    - require:
      - file: {{ formula }}-k3s-binary-prerequisites

{{ formula }}-k3s-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/k3s
    - target: {{ d.k3s.pkg.binary.name }}/bin/k3s
    - force: True
    - require:
      - file: {{ formula }}-k3s-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}
