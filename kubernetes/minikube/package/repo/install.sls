# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

k8s-minikube-package-repo-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(k8s.minikube.pkg.repo) }}
    - onlyif: {{ k8s.minikube.pkg.repo and k8s.minikube.pkg.use_upstream_repo }}
