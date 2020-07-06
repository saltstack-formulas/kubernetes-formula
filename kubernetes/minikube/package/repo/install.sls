# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-minikube-package-repo-managed:
  pkgrepo.managed:
    {{- format_kwargs(d.minikube.pkg.repo) }}
    - onlyif: {{ d.minikube.pkg.repo and d.minikube.pkg.use_upstream_repo }}
