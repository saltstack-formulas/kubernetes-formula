# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_install = tplroot ~ '.minikube.binary' %}
{%- set sls_package_install = tplroot ~ '.minikube.package' %}
{%- set sls_source_install = tplroot ~ '.minikube.source' %}

    {%- if 'environ' in k8s.minikube and k8s.minikube.environ %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_binary_install }}
  - {{ sls_package_install }}
  - {{ sls_source_install }}

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
        environ: {{ k8s.minikube.environ|json }}
    - require:
      - sls: {{ sls_binary_install }}
      - sls: {{ sls_package_install }}
      - sls: {{ sls_source_install }}

    {%- endif %}
