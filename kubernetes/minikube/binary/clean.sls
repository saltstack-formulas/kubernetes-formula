# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-minikube-release-binary-clean-file-absent:
  file.absent:
    - names:
      - /tmp/dummy_file_entry
           {%- if k8s.minikube.pkg.use_upstream_binary %}
      - {{ k8s.minikube.pkg.binary.name }}/bin/minikube
           {%- endif %}
           {%- if k8s.minikube.linux.altpriority|int > 0 %}
      - /usr/local/bin/minikube
           {%- endif %}

k8s-minikube-release-binary-clean-file-symlink:
  file.absent:
    - name: {{ k8s.minikube.linux.symlink }}
    - unless:
      - {{ k8s.minikube.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows', 'arch') }}
