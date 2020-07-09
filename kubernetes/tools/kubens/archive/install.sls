# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-tools-kubens-archive-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-tools-kubens-archive-install
  file.directory:
    - name: {{ d.kubens.pkg.archive.name }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: {{ formula }}-tools-kubens-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(d.kubens.pkg.archive) }}
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
    - require:
      - file: {{ formula }}-tools-kubens-archive-install

        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.kubens.pkg.commands %}

{{ formula }}-tools-kubens-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.kubens.pkg.archive.name }}/{{ cmd }}
    - force: True
    - require:
      - archive: {{ formula }}-tools-kubens-archive-install

            {%- endfor %}
        {%- endif %}
    {%- else %}

{{ formula }}-tools-kubens-archive-install-other:
  test.show_notification:
    - text: |
        The kubens archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
