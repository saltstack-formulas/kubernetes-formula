# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_install = tplroot ~ '.minikube.binary.install' %}
{%- set sls_package_install = tplroot ~ '.minikube.package.install' %}
{%- set sls_source_install = tplroot ~ '.minikube.source.install' %}

    {%- if 'config' in k8s.minikube and k8s.minikube.config %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  {{ '- ' + sls_package_install if k8s.minikube.pkg.use_upstream_repo else '' }}
  {{ '- ' + sls_source_install if k8s.minikube.pkg.use_upstream_source else '' }}
  {{ '- ' + sls_binary_install if k8s.minikube.pkg.use_upstream_binary else '' }}

k8s-minikube-config-file-install-file-managed:
  file.managed:
    - name: {{ k8s.minikube.config_file }}
    - source: {{ files_switch(['config.yml.jinja'],
                              lookup='k8s-minikube-config-file-install-file-managed'
                 )
              }}
    - mode: 644
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        config: {{ k8s.minikube.config|json }}
    - require:
      {{ '- sls: ' + sls_package_install if k8s.minikube.pkg.use_upstream_repo else '' }}
      {{ '- sls: ' + sls_source_install if k8s.minikube.pkg.use_upstream_source else '' }}
      {{ '- sls: ' + sls_binary_install if k8s.minikube.pkg.use_upstream_binary else '' }}

    {%- endif %}
