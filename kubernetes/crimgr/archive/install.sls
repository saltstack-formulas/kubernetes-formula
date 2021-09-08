#  -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {%- if grains.kernel|lower == 'linux' %}
        {%- if d.crimgr.pkg and d.crimgr.pkg['use_upstream'] == 'archive' and 'archive' in d.crimgr.pkg %}

kubernetes-cri-resource-manager-archive-install:
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

        {%- else %}

kubernetes-cri-resource-manager-archive-install-nothing:
  test.show_notification:
    - text: |
        The cri-resource-manager archive is not defined so skipping.

        {%- endif %}
    {%- else %}

kubernetes-cri-resource-manager-archive-install-other:
  test.show_notification:
    - text: |
        The cri-resource-manager archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
