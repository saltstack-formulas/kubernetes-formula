# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if grains.kernel|lower in ('linux', 'darwin', 'windows') %}
    {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}
    {%- if d.client.pkg.use_upstream == 'archive' and 'pkg' in d.client and 'archive' in d.client['pkg'] %}

{{ formula }}-client-archive-install:
         {%- if grains.os != 'Windows' %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-client-archive-install
         {%- endif %}
  file.directory:
    - name: {{ d.client.pkg.path }}
    - makedirs: True
    - clean: {{ d.clean }}
    - require_in:
      - archive: {{ formula }}-client-archive-install
             {%- if grains.os != 'Windows' %}
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
             {%- endif %}
  archive.extracted:
    {{- format_kwargs(d.client['pkg']['archive']) }}
    - retry: {{ d.retry_option|json }}
    - enforce_toplevel: false
    - trim_output: true
             {%- if grains.os != 'Windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
             {%- endif %}
    - require:
      - file: {{ formula }}-client-archive-install

        {%- if (d.linux.altpriority|int == 0 and grains.os != 'Windows') or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.client.pkg.commands|unique %}

{{ formula }}-client-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.client.pkg.path }}/bin/{{ cmd }}
    - force: True
    - require:
      - archive: {{ formula }}-client-archive-install

            {%- endfor %}
        {%- endif %}
    {%- endif %}
{%- else %}

{{ formula }}-client-archive-install-other:
  test.show_notification:
    - text: |
        The client archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

{%- endif %}
