# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_clean = tplroot ~ '.kubectl.binary.clean' %}
{%- set sls_package_clean = tplroot ~ '.kubectl.package.clean' %}
{%- set sls_source_clean = tplroot ~ '.kubectl.source.clean' %}

  {%- if k8s.kernel == 'linux' and k8s.kubectl.linux.altpriority|int > 0 %}

include:
  - {{ sls_package_clean }}
  - {{ sls_source_clean }}
  - {{ sls_binary_clean }}

k8s-kubectl-config-alternatives-clean-k8s-kubectl-alternative-remove:
  alternatives.remove:
    - name: link-k8s-kubectl
    - path: {{ k8s.dir.binary }}/{{ k8s.kubectl.pkg.binary.name }}/bin/kubectl
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-kubectl
    - require:
      - sls: {{ sls_package_clean }}
      - sls: {{ sls_source_clean }}
      - sls: {{ sls_binary_clean }}

  {%- endif %}
