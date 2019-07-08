# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_config_clean = tplroot ~ '.kubectl.config.clean' %}

include:
  - {{ sls_config_clean }}

k8s-kubectl-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ k8s.kubectl.pkg.name }}
