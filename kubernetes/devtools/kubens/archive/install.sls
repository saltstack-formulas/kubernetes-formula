# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-devtools-kubens-archive-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-devtools-kubens-archive-install
  file.directory:
    - name: {{ d.devtools.kubens.pkg.archive.name }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: {{ formula }}-devtools-kubens-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(d.devtools.kubens.pkg.archive) }}
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
    - require:
      - file: {{ formula }}-devtools-kubens-archive-install

        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.devtools.kubens.pkg.commands %}

{{ formula }}-devtools-kubens-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.devtools.kubens.pkg.archive.name }}/{{ cmd }}
    - force: True
    - require:
      - archive: {{ formula }}-devtools-kubens-archive-install

            {%- endfor %}
        {%- endif %}
    {%- else %}

{{ formula }}-devtools-kubens-archive-install-other:
  test.show_notification:
    - text: |
        The kubens archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
