# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- set sls_binary_clean = tplroot ~ '.kubectl.binary.clean' %}
{%- set sls_package_clean = tplroot ~ '.kubectl.package.clean' %}

include:
  - {{ sls_binary_clean if d.kubectl.pkg.use_upstream_binary else sls_package_clean }}
  - .alternatives.clean

{{ formula }}-kubectl-config-clean:
  file.absent:
    - names:
      - {{ d.kubectl.config_file }}
      - {{ d.kubectl.environ_file }}
    - require:
      - sls: {{ sls_binary_clean if d.kubectl.pkg.use_upstream_binary else sls_package_clean }}
