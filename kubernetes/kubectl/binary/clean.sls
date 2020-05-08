# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-kubectl-release-binary-clean-file-absent:
  file.absent:
    - names:
      - /tmp/dummy_file_entry
           {%- if k8s.kubectl.pkg.use_upstream_binary %}
      - {{ k8s.kubectl.pkg.binary.name }}/bin/kubectl
           {%- endif %}
           {%- if k8s.kubectl.linux.altpriority|int > 0 %}
      - /usr/local/bin/kubectl
           {%- endif %}

k8s-kubectl-release-binary-clean-file-symlink:
  file.absent:
    - name: {{ k8s.kubectl.linux.symlink }}
    - unless:
      - {{ k8s.kubectl.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows', 'arch') }}
