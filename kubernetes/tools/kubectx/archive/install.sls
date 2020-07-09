# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-tools-kubectx-archive-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-tools-kubectx-archive-install
  file.directory:
    - name: {{ d.kubectx.pkg.archive.name }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: {{ formula }}-tools-kubectx-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(d.kubectx.pkg.archive) }}
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
    - require:
      - file: {{ formula }}-tools-kubectx-archive-install

        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.kubectx.pkg.commands %}

{{ formula }}-tools-kubectx-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.kubectx.pkg.archive.name }}/{{ cmd }}
    - force: True
    - require:
      - archive: {{ formula }}-tools-kubectx-archive-install

            {%- endfor %}
        {%- endif %}
    {%- else %}

{{ formula }}-tools-kubectx-archive-install-other:
  test.show_notification:
    - text: |
        The kubectx archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
