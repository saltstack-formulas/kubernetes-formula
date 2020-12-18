# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set sls_archive_clean = tplroot ~ '.server.archive.clean' %}
{%- set sls_package_clean = tplroot ~ '.server.package.clean' %}

include:
  - {{ sls_archive_clean if d.server.pkg.use_upstream == 'archive' else sls_package_clean }}

kubernetes-server-config-clean:
  file.absent:
    - names:
      - {{ d.server.config_file }}
      - {{ d.server.environ_file }}
    - require:
      - sls: {{ sls_archive_clean if d.server.pkg.use_upstream == 'archive' else sls_package_clean }}
