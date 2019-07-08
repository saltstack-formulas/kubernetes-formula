# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

    {%- if k8s.pkg.use_upstream_repo %}

include:
  - .repo.clean

    {%- endif %}
    {%- if 'deps' in k8s.pkg and k8s.pkg.deps %}

k8s-package-clean-pkg-deps-removed:
  pkg.removed:
    - names: {{ k8s.pkg.deps }}

    {%- endif %}
    {%- if 'name' in k8s.pkg and k8s.pkg.name %}

k8s-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ k8s.pkg.name }}

    {%- endif %}
