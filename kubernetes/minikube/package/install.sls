# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
 
    {%- if grains.os_family == 'MacOS' %}

k8s-minikube-package-install-pkg-installed:
  cmd.run:
    - name: brew cask install {{ k8s.minikube.pkg.name }}

    {%- else %}

k8s-minikube-package-install-pkg-installed:
  pkg.installed:
    - name: {{ k8s.minikube.pkg.name }}

    {%- endif %}
