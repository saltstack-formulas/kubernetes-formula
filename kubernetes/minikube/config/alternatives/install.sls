# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_install = tplroot ~ '.minikube.binary.install' %}
{%- set sls_package_install = tplroot ~ '.minikube.package.install' %}
{%- set sls_source_install = tplroot ~ '.minikube.source.install' %}

  {%- if k8s.kernel == 'linux' and k8s.minikube.linux.altpriority|int > 0 %}

include:
  {{ '- ' + sls_package_install if k8s.minikube.pkg.use_upstream_repo }}
  {{ '- ' + sls_source_install if k8s.minikube.pkg.use_upstream_source }}
  {{ '- ' + sls_binary_install if k8s.minikube.pkg.use_upstream_binary }}

k8s-minikube-config-alternatives-install-k8s-minikube-alternative-install:
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/minikube link-k8s-minikube {{ k8s.minikube.pkg.binary.basedir }}/bin/minikube {{ k8s.minikube.linux.altpriority }}
  alternatives.install:
    - name: link-k8s-minikube
    - link: /usr/local/bin/minikube
    - path: {{ k8s.minikube.pkg.binary.basedir }}/bin/minikube
    - priority: {{ k8s.minikube.linux.altpriority }}
    - order: 10
    - require:
      {{ '- sls: ' + sls_package_install if k8s.minikube.pkg.use_upstream_repo }}
      {{ '- sls: ' + sls_source_install if k8s.minikube.pkg.use_upstream_source }}
      {{ '- sls: ' + sls_binary_install if k8s.minikube.pkg.use_upstream_binary }}
    - unless: {{ grains.os_family in ('Suse',) }}

k8s-minikube-config-alternatives-install-k8s.minikube-alternative-set:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse',) }}
    - name: link-k8s-minikube
    - path: {{ k8s.minikube.pkg.binary.basedir }}/bin/minikube
    - require:
      - alternatives: k8s-minikube-config-alternatives-install-k8s-minikube-alternative-install
      {{ '- sls: ' + sls_package_install if k8s.minikube.pkg.use_upstream_repo }}
      {{ '- sls: ' + sls_source_install if k8s.minikube.pkg.use_upstream_source }}
      {{ '- sls: ' + sls_binary_install if k8s.minikube.pkg.use_upstream_binary }}

  {%- endif %}
