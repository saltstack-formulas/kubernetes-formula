# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_clean = tplroot ~ '.kubectl.binary.clean' %}
{%- set sls_package_clean = tplroot ~ '.kubectl.package.clean' %}
{%- set sls_source_clean = tplroot ~ '.kubectl.source.clean' %}

include:
  {{ '- ' + sls_package_clean if k8s.kubectl.pkg.use_upstream_repo else '' }}
  {{ '- ' + sls_source_clean if k8s.kubectl.pkg.use_upstream_source else '' }}
  {{ '- ' + sls_binary_clean if k8s.kubectl.pkg.use_upstream_binary else '' }}
  - .alternatives.clean

k8s-kubectl-config-clean-file-absent:
  file.absent:
    - names:
      - {{ k8s.kubectl.config_file }}
      - {{ k8s.kubectl.environ_file }}
    - require:
      {{ '- sls: ' + sls_package_clean if k8s.kubectl.pkg.use_upstream_repo else '' }}
      {{ '- sls: ' + sls_source_clean if k8s.kubectl.pkg.use_upstream_source else '' }}
      {{ '- sls: ' + sls_binary_clean if k8s.kubectl.pkg.use_upstream_binary else '' }}
