# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_clean = tplroot ~ '.minikube.binary.clean' %}
{%- set sls_package_clean = tplroot ~ '.minikube.package.clean' %}
{%- set sls_source_clean = tplroot ~ '.minikube.source.clean' %}

    {%- if 'environ' in k8s.minikube and k8s.minikube.environ %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_binary_clean }}
  - {{ sls_package_clean }}
  - {{ sls_source_clean }}

k8s-minikube-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ k8s.minikube.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='k8s-minikube-config-file-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        config: {{ k8s.minikube.environ|json }}
    - require:
      - sls: {{ sls_binary_clean }}
      - sls: {{ sls_package_clean }}
      - sls: {{ sls_source_clean }}

    {%- endif %}
