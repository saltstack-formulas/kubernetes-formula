# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

k8s-kubectl-package-repo-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(k8s.kubectl.pkg.repo) }}
    - onlyif: {{ k8s.kubectl.pkg.repo }}
