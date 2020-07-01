# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_clean = tplroot ~ '.minikube.binary.clean' %}
{%- set sls_package_clean = tplroot ~ '.minikube.package.clean' %}
{%- set sls_source_clean = tplroot ~ '.minikube.source.clean' %}

include:
  {{ '- ' + sls_package_clean if k8s.minikube.pkg.use_upstream_repo else '' }}
  {{ '- ' + sls_source_clean if k8s.minikube.pkg.use_upstream_source else '' }}
  {{ '- ' + sls_binary_clean if k8s.minikube.pkg.use_upstream_binary else '' }}
  - .alternatives.clean

k8s-minikube-config-clean-file-absent:
  file.absent:
    - names:
      - {{ k8s.minikube.config_file }}
      - {{ k8s.minikube.environ_file }}
    - require:
      {{ '- sls: ' + sls_package_clean if k8s.minikube.pkg.use_upstream_repo else '' }}
      {{ '- sls: ' + sls_source_clean if k8s.minikube.pkg.use_upstream_source else '' }}
      {{ '- sls: ' + sls_binary_clean if k8s.minikube.pkg.use_upstream_binary else '' }}
