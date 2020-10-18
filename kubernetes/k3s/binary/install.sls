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
        {%- else %}
  cmd.run:
    - name: mv {{ d.k3s.pkg.path }}k3s {{ d.k3s.pkg.path }}k3s.exe
    - onlyif: test -f {{ d.k3s.pkg.path }}k3s

        {%- endif %}
        {%- if (d.linux.altpriority|int == 0 and grains.os != 'Windows') or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.k3s.pkg['commands']|unique %}

{{ formula }}-k3s-binary-install-symlink:
  file.symlink:
    - unless: {{ grains.os == 'Windows' }} || false
    - name: /usr/local/bin/k3s
    - target: {{ d.k3s.pkg.path }}/k3s
    - force: True
    - require:
      - file: {{ formula }}-k3s-binary-install
    - unless: {{ d.linux.altpriority|int > 0 }} || false

            {%- endfor %}
        {%- endif %}
    {%- endif %}
