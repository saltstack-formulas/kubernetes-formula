# -*- coding: utf-8 -*-
# vim: ft=sls

{%- if grains.kernel|lower in ('linux', 'darwin') %}
    {%- set tplroot = tpldir.split('/')[0] %}
    {%- from tplroot ~ "/map.jinja" import data as d with context %}
    {%- set formula = d.formula %}

    {%- set sls_archive_install = tplroot ~ '.server.archive.install' %}
    {%- set sls_package_install = tplroot ~ '.server.package.install' %}

include:
  - {{ sls_archive_install if d.server.pkg.use_upstream == 'archive' else sls_package_install }}
  - .config
  - .alternatives

{%- else %}

{{ formula }}-server-archive-install-other:
  test.show_notification:
    - text: |
        The server archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

{%- endif %}
