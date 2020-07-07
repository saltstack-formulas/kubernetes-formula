# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-kubebuilder-archive-absent:
  file.absent:
    - names:
      - {{ d.kubebuilder.pkg.archive.path }}
      - /usr/local/bin/kubebuilder
