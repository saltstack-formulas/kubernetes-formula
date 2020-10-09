# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.k3s.pkg.use_upstream == 'binary' %}

{{ formula }}-k3s-binary-prerequisites:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
  file.directory:
    - name: {{ d.k3s.pkg.path }}/bin
    - mode: 755
    - makedirs: True
              {%- if grains.os != 'Windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
              {%- endif %}
    - require:
      - pkg: {{ formula }}-k3s-binary-prerequisites

{{ formula }}-k3s-binary-install:
  file.managed:
    - name: {{ d.k3s.pkg.path }}/bin/k3s
    - source: {{ d.k3s.pkg.binary.source }}
    - source_hash: {{ d.k3s.pkg.binary.source_hash }}
    - mode: 755
    - retry: {{ d.retry_option|json }}
    - require:
      - file: {{ formula }}-k3s-binary-prerequisites
              {%- if grains.os != 'Windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
              {%- endif %}

{{ formula }}-k3s-binary-install-symlink:
  file.symlink:
    - unless: {{ grains.os == 'Windows' }}
    - name: /usr/local/bin/k3s
    - target: {{ d.k3s.pkg.path }}/bin/k3s
    - force: True
    - require:
      - file: {{ formula }}-k3s-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}

    {%- endif %}
