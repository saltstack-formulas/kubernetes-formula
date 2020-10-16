# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.client.pkg.use_upstream == 'binary' %}

{{ formula }}-client-binary-install:
        {%- if grains.os != 'Windows' %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-client-binary-install
        {%- endif %}
  file.managed:
    - name: {{ d.client.pkg.path }}
    - source: {{ d.client.pkg.binary.source }}
        {%- if 'source_hash' in d.client.pkg.binary and d.client.pkg.binary.source_hash %}
    - source_hash: {{ p[tool]['binary']['source_hash'] }}
        {%- else %}
    - skip_verify: True
        {%- endif %}
    - makedirs: True
    - retry: {{ d.retry_option|json }}
        {%- if grains.os != 'Windows' %}
    - mode: '0755'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}

        {%- endif %}
        {%- if grains.os != 'Windows' %}

{{ formula }}-client-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/kubectl
    - target: {{ d.client.pkg.path }}/bin/kubectl
    - force: True
    - require:
      - cmd: {{ formula }}-client-binary-install
    - unless: {{ d.linux.altpriority|int > 0 }} || false

        {%- endif %}
    {%- endif %}
