# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- set sls_alternatives_clean = tplroot ~ '.kubebuilder.archive.alternatives.clean' %}

include:
  - {{ sls_alternatives_clean }}

{{ formula }}-kubebuilder-archive-absent:
  file.absent:
    - names:
      - /usr/local/bin/kubebuilder
      - {{ d.kubebuilder.pkg.archive.name }}/bin
