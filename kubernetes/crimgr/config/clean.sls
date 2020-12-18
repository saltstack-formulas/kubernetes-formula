# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set sls_archive_clean = tplroot ~ '.crimgr.archive.clean' %}

include:
  - {{ sls_archive_clean }}

kubernetes-crimgr-config-clean:
  file.absent:
    - names:
      - {{ d.crimgr.config_file }}
      - {{ d.crimgr.environ_file }}
    - require:
      - sls: {{ sls_archive_clean }}
