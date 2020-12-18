# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

kubernetes-package-repo-absent:
  pkgrepo.absent:
    - name: {{ d.pkg.repo.name }}
    - onlyif:
      - {{ d.pkg.repo }}
