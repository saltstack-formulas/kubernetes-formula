# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-minikube-package-repo-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ k8s.minikube.pkg.repo.name }}
    - onlyif: {{ k8s.minikube.pkg.repo and k8s.minikube.pkg.use_upstream_repo }}
