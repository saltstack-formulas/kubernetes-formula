# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

include:
  {{ '- .package' if k8s.kubectl.pkg.use_upstream_repo else '' }}
  {{ '- .binary' if k8s.kubectl.pkg.use_upstream_binary else '' }}
  {{ '- .source' if k8s.kubectl.pkg.use_upstream_source else '' }}
  - .config
