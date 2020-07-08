# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- set sls_archive_clean = tplroot ~ '.server.archive.clean' %}
{%- set sls_package_clean = tplroot ~ '.server.package.clean' %}

include:
  - {{ sls_archive_clean }}
  - {{ sls_package_clean }}

{{ formula }}-server-config-clean:
  file.absent:
    - names:
      - {{ d.server.config_file }}
      - {{ d.server.environ_file }}
    - require:
      - sls: {{ sls_archive_clean }}
      - sls: {{ sls_package_clean }}
