# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

include:
  {{ '- .script' if d.k3s.pkg.use_upstream == 'script' else '' }}
  {{ '- .binary' if d.k3s.pkg.use_upstream == 'binary' else '' }}
  - .config
