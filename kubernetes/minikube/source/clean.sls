# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-minikube-release-source-clean-file-absent:
  file.absent:
    - names:
      - /tmp/dummy_file_entry
           {%- if k8s.minikube.pkg.use_upstream_source %}
      - {{ k8s.minikube.pkg.source.name }}/bin/minikube
           {%- endif %}
           {%- if k8s.minikube.linux.altpriority|int > 0 %}
      - /usr/local/bin/minikube
           {%- endif %}

