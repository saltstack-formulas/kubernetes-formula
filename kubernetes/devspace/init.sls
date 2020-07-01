# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

include:
  {{ '- .binary' if k8s.devspace.pkg.use_upstream_binary else '' }}
  - .config
