# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower in ('linux', 'darwin') %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-node-archive-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-node-archive-install
  file.directory:
    - name: {{ d.node.pkg.archive.name }}
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
    {{- format_kwargs(d.node.pkg.archive) }}
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
    - require:
      - file: {{ formula }}-node-archive-install

        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.node.pkg.commands %}

{{ formula }}-node-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.node.pkg.archive.name }}/bin/{{ cmd }}
    - force: True
    - require:
      - archive: {{ formula }}-node-archive-install

            {%- endfor %}
        {%- endif %}
    {%- else %}

{{ formula }}-node-archive-install-other:
  test.show_notification:
    - text: |
        The node archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
