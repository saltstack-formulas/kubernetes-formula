# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-kubectl-package-repo-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ k8s.kubectl.pkg.repo.name }}
    - onlyif: {{ k8s.kubectl.pkg.repo }}
