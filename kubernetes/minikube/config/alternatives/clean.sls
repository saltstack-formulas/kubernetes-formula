# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_clean = tplroot ~ '.minikube.binary.clean' %}
{%- set sls_package_clean = tplroot ~ '.minikube.package.clean' %}
{%- set sls_source_clean = tplroot ~ '.minikube.source.clean' %}

  {%- if k8s.kernel == 'linux' and k8s.minikube.linux.altpriority|int > 0 %}

include:
  - {{ sls_package_clean }}
  - {{ sls_source_clean }}
  - {{ sls_binary_clean }}

k8s-minikube-config-alternatives-clean-k8s-minikube-alternative-remove:
  alternatives.remove:
    - name: link-k8s-minikube
    - path: {{ k8s.minikube.pkg.binary.basedir }}/bin/minikube
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-minikube
    - require:
      - sls: {{ sls_package_clean }}
      - sls: {{ sls_source_clean }}
      - sls: {{ sls_binary_clean }}

  {%- endif %}
