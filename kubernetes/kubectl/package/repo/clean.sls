# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-kubectl-package-repo-absent:
  pkgrepo.absent:
    - name: {{ d.kubectl.pkg.repo.name }}
    - onlyif: {{ d.kubectl.pkg.repo }}
