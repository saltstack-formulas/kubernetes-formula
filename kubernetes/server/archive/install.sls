# -*- coding: utf-8 -*-
# vim: ft=sls

{%- if grains.kernel|lower in ('linux', 'darwin') %}
    {%- set tplroot = tpldir.split('/')[0] %}
    {%- from tplroot ~ "/map.jinja" import data as d with context %}
    {%- set formula = d.formula %}
    {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}
    {%- if d.server.pkg['use_upstream'] == 'archive' and 'archive' in d.server.pkg %}

{{ formula }}-server-archive-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-server-archive-install
  file.directory:
    - name: {{ d.server.pkg.path }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: {{ formula }}-server-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(d.server['pkg']['archive']) }}
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - enforce_toplevel: false
    - trim_output: true
    - recurse:
        - user
        - group
    - require:
      - file: {{ formula }}-server-archive-install

            {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                {%- for cmd in d.server.pkg.commands|unique %}

{{ formula }}-server-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.server.pkg.path }}/bin/{{ cmd }}
    - force: True
    - require:
      - archive: {{ formula }}-server-archive-install

                {%- endfor %}
            {%- endif %}

    {%- endif %}
{%- else %}

{{ formula }}-server-archive-install-other:
  test.show_notification:
    - text: |
        The server archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

{%- endif %}
