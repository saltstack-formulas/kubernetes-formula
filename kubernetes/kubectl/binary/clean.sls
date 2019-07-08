# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-kubectl-release-binary-clean-file-absent:
  file.absent:
    - names:
      - {{ k8s.dir.binary }}/{{ k8s.kubectl.pkg.binary.name }}/bin/kubectl*
           {%- if k8s.kubectl.linux.altpriority|int == 0 and k8s.kernel in ('linux', 'darwin') %}
      - /usr/local/bin/kubectl
           {%- endif %}
