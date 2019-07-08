# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-kubectl-release-source-clean-file-absent:
  file.absent:
    - names:
      - {{ k8s.kubectl.pkg.source.basedir }}
      - /usr/local/bin/kubectl
