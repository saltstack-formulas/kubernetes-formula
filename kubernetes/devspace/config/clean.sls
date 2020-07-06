# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- set sls_binary_clean = tplroot ~ '.devspace.binary.clean' %}

include:
  - {{ sls_binary_clean }}
  - .alternatives.clean

{{ formula }}-devspace-config-clean:
  file.absent:
    - names:
      - {{ d.devspace.config_file }}
      - {{ d.devspace.environ_file }}
    - require:
      - sls: {{ sls_binary_clean }}
