# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_clean = tplroot ~ '.devspace.binary.clean' %}

include:
  {{ '- ' + sls_binary_clean if k8s.devspace.pkg.use_upstream_binary else '' }}
  - .alternatives.clean

k8s-devspace-config-clean-file-absent:
  file.absent:
    - names:
      - {{ k8s.devspace.config_file }}
      - {{ k8s.devspace.environ_file }}
    - require:
      {{ '- sls: ' + sls_binary_clean if k8s.devspace.pkg.use_upstream_binary else '' }}
