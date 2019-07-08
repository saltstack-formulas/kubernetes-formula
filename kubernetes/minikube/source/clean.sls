# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-minikube-release-source-clean-file-absent:
  file.absent:
    - names:
      - {{ k8s.dir.source }}/{{ k8s.minikube.pkg.source.name }}
      - /usr/local/bin/minikube
