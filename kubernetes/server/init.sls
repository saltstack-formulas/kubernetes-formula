# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower in ('linux', 'darwin') %}

include:
  - .archive.install
  - .package.install
  - .config
  - .alternatives

    {%- else %}
        {%- set tplroot = tpldir.split('/')[0] %}
        {%- from tplroot ~ "/map.jinja" import data as d with context %}

kubernetes-server-archive-install-other:
  test.show_notification:
    - text: |
        The server is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
