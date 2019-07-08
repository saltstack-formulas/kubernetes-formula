# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
 
k8s-kubectl-package-install-pkg-installed:
  pkg.installed:
    - name: {{ k8s.kubectl.pkg.name }}
