# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes with context %}

    {%- if 'name' in kubernetes.pkg and kubernetes.pkg.name %}

kubernetes-package-install-pkg-installed:
  pkg.installed:
    - name: {{ kubernetes.pkg.name }}

    {%- endif %}
    {%- if 'deps' in kubernetes.pkg and kubernetes.pkg.deps %}

kubernetes-package-install-pkg-deps-installed:
  pkg.installed:
    - names: {{ kubernetes.pkg.deps }}

    {%- endif %}
