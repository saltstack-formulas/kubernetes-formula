# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_package_clean = tplroot ~ '.package.clean' %}

    {%- if 'repo' in k8s.pkg and k8s.pkg.repo %}

include:
  - {{ sls_package_clean }}

k8s-package-repo-clean-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ k8s.pkg.repo.humanname }}

    {%- endif %}
