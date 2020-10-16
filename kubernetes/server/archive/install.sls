# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if grains.kernel|lower in ('linux', 'darwin') %}
    {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}
    {%- if d.server.pkg['use_upstream'] == 'archive' and 'archive' in d.server.pkg %}

{{ formula }}-server-archive-install:
             {%- if grains.os != 'Windows' %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-server-archive-install
             {%- endif %}
  file.directory:
    - name: {{ d.server.pkg.path }}
    - makedirs: True
    - clean: {{ d.clean }}
    - require_in:
      - archive: {{ formula }}-server-archive-install
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
    {{- format_kwargs(d.server['pkg']['archive']) }}
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
      - file: {{ formula }}-server-archive-install

            {%- if (d.linux.altpriority|int == 0 and grains.os != 'Windows') or grains.os_family in ('Arch', 'MacOS') %}
                {%- for cmd in d.server.pkg.commands|unique %}

{{ formula }}-server-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.server.pkg.path }}{{ cmd }}
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
