# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if 'config_file' in d.k3s and d.k3s.config_file %}
    {%- set sls_binary_clean = tplroot ~ '.k3s.binary.clean' %}
    {%- set sls_script_clean = tplroot ~ '.k3s.script.clean' %}

include:
  - {{ sls_archive_clean if d.k3s.pkg.use_upstream == 'archive' else sls_script_clean }}

{{ formula }}-k3s-config-clean:
  file.absent:
    - names:
      - {{ d.k3s.config_file }}
    - require:
      - sls: {{ sls_archive_clean if d.k3s.pkg.use_upstream == 'archive' else sls_script_clean }}

{%- endif %}
