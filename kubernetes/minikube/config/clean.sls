# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- set sls_binary_clean = tplroot ~ '.minikube.binary.clean' %}
{%- set sls_package_clean = tplroot ~ '.minikube.package.clean' %}

include:
  - {{ sls_binary_clean if d.minikube.pkg.use_upstream_binary else sls_package_clean }}
  - .alternatives.clean

{{ formula }}-minikube-config-clean:
  file.absent:
    - names:
      - {{ d.minikube.config_file }}
      - {{ d.minikube.environ_file }}
    - require:
      - sls: {{ sls_binary_clean if d.minikube.pkg.use_upstream_binary else sls_package_clean }}
