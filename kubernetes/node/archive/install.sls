# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {%- if d.node.pkg.use_upstream == 'archive' and 'archive' in d.node.pkg %}

{{ formula }}-node-archive-install:
        {%- if grains.os_family != 'Windows' %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-node-archive-install
        {%- endif %}
  file.directory:
    - name: {{ d.node.pkg.path }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: {{ formula }}-node-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(d.node['pkg']['archive']) }}
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - enforce_toplevel: false
    - trim_output: true
    - recurse:
        - user
        - group
    - require:
      - file: {{ formula }}-node-archive-install

        {%- if (d.linux.altpriority|int == 0 and grains.os_family != 'Windows') or grains.os_family in ('Arch', 'MacOS',) %}
            {%- for cmd in d.node.pkg.commands|unique %}

{{ formula }}-node-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.node.pkg.path }}/bin/{{ cmd }}
    - force: True
    - require:
      - archive: {{ formula }}-node-archive-install

            {%- endfor %}
        {%- endif %}
    {%- endif %}
