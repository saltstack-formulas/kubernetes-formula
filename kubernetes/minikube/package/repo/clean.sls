# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-minikube-package-repo-absent:
  pkgrepo.absent:
    - name: {{ d.minikube.pkg.repo.name }}
    - onlyif: {{ d.minikube.pkg.repo and d.minikube.pkg.use_upstream_repo }}
