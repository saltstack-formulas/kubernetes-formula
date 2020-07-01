# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-devspace-release-binary-clean-file-absent:
  file.absent:
    - names:
      - /tmp/dummy_file_entry
           {%- if k8s.devspace.pkg.use_upstream_binary %}
      - {{ k8s.devspace.pkg.binary.name }}/bin/devspace
           {%- endif %}
           {%- if k8s.devspace.linux.altpriority|int > 0 %}
      - /usr/local/bin/devspace
           {%- endif %}

k8s-devspace-release-binary-clean-file-symlink:
  file.absent:
    - name: {{ k8s.devspace.linux.symlink }}
    - unless:
      - {{ k8s.devspace.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows', 'arch') }}
