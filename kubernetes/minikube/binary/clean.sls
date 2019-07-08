# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-minikube-release-binary-clean-file-absent:
  file.absent:
    - names:
      - {{ k8s.dir.binary }}/{{ k8s.minikube.pkg.binary.name }}/bin/minikube*
           {%- if k8s.minikube.linux.altpriority|int == 0 and k8s.kernel in ('linux', 'darwin')  %}
      - /usr/local/bin/minikube
           {%- endif %}

