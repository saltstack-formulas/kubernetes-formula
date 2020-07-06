# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-kubectl-package-repo-managed:
  pkgrepo.managed:
    {{- format_kwargs(k8s.kubectl.pkg.repo) }}
    - onlyif: {{ d.kubectl.pkg.repo }}
