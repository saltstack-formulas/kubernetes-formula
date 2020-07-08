# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower in ('linux', 'darwin') %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-client-archive-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-client-archive-install
  file.directory:
    - name: {{ d.client.pkg.archive.name }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: {{ formula }}-client-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(d.client.pkg.archive) }}
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
    - require:
      - file: {{ formula }}-client-archive-install

        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.client.pkg.commands %}

{{ formula }}-client-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.client.pkg.archive.name }}/bin/{{ cmd }}
    - force: True
    - require:
      - archive: {{ formula }}-client-archive-install

            {%- endfor %}
        {%- endif %}
    {%- else %}

{{ formula }}-client-archive-install-other:
  test.show_notification:
    - text: |
        The client archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
