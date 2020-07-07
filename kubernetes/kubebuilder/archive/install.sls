# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower in ('linux', 'darwin') %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-kubebuilder-archive-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - file: {{ formula }}-kubebuilder-archive-install
  file.directory:
    - name: {{ d.kubebuilder.pkg.archive.name }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - clean: True
    - require_in:
      - archive: {{ formula }}-kubebuilder-archive-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(d.kubebuilder.pkg.archive) }}
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
    - require:
      - file: {{ formula }}-kubebuilder-archive-install

        {%- if d.linux.altpriority|int == 0 %}

{{ formula }}-archive-install-symlink-kubebuilder:
  file.symlink:
    - name: /usr/local/bin/kubebuilder
    - target: {{ d.kubebuilder.pkg.archive.name }}/bin/kubebuilder
    - force: True
    - require:
      - archive: {{ formula }}-kubebuilder-archive-install

        {%- endif %}
    {%- else %}

{{ formula }}-kubebuilder-archive-install-other:
  test.show_notification:
    - text: |
        The kubebuilder archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
