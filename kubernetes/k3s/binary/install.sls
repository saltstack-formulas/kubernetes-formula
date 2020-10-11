# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.k3s.pkg.use_upstream == 'binary' %}

{{ formula }}-k3s-binary-install:
        {%- if grains.os != 'Windows' %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-k3s-binary-install
        {%- endif %}
  file.managed:
    - name: {{ d.k3s.pkg.path }}k3s
    - source: {{ d.k3s.pkg.binary.source }}
    - source_hash: {{ d.k3s.pkg.binary.source_hash }}
    - makedirs: True
    - retry: {{ d.retry_option|json }}
              {%- if grains.os != 'Windows' %}
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
              {%- endif %}

        {%- if grains.os != 'Windows' %}

{{ formula }}-k3s-binary-install-symlink:
  file.symlink:
    - unless: {{ grains.os == 'Windows' }}
    - name: /usr/local/bin/k3s
    - target: {{ d.k3s.pkg.path }}k3s
    - force: True
    - require:
      - file: {{ formula }}-k3s-binary-install
    - unless: {{ d.linux.altpriority|int > 0 }}
        {%- endif %}

    {%- endif %}
