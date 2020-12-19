#  -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {%- if grains.kernel|lower == 'linux' %}
        {%- if d.crimgr.pkg and d.crimgr.pkg['use_upstream'] == 'archive' and 'archive' in d.crimgr.pkg %}

kubernetes-cri-resource-manager-archive-install:
  file.directory:
    - name: {{ d.crimgr.pkg['path'] }}
    - makedirs: True
    - clean: {{ d.clean }}
    - require_in:
      - archive: kubernetes-cri-resource-manager-archive-install
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
      - user
      - group
      - mode
  archive.extracted:
    {{- format_kwargs(d.crimgr.pkg['archive']) }}
    - retry: {{ d.retry_option }}
    - enforce_toplevel: false
    - trim_output: true
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
      - user
      - group

            {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                {%- for cmd in d.crimgr.pkg['commands']|unique %}

kubernetes-cri-resource-manager-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target:  {{ d.crimgr.pkg['path'] }}/bin/{{ cmd }}
    - force: True
    - onlyif:
      - test -f {{ d.crimgr.pkg['path'] }}/bin/{{ cmd }}
    - require:
      - archive: kubernetes-cri-resource-manager-archive-install

                {%- endfor %}
            {%- endif %}
        {%- endif %}
    {%- else %}

kubernetes-cri-resource-manager-archive-install-other:
  test.show_notification:
    - text: |
        The cri-resource-manager archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
