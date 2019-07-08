# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

include:
  {{ '- .package' if k8s.minikube.pkg.use_upstream_repo }}
  {{ '- .binary' if k8s.minikube.pkg.use_upstream_source }}
  {{ '- .source' if k8s.minikube.pkg.use_upstream_binary }}
  - .config
