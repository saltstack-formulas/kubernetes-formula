# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

kubernetes-package-repo-managed:
  pkgrepo.managed:
    {{- format_kwargs(d.pkg.repo) }}
    - onlyif:
      - {{ d.pkg.repo }}
