# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-package-repo-managed:
  pkgrepo.managed:
    {{- format_kwargs(d.pkg.repo) }}
    - onlyif:
      - {{ d.pkg.repo }}
