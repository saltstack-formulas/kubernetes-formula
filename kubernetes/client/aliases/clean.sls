# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

kubernetes-client-aliases-clean:
  file.absent:
    - names:
      - {{ d.client.aliases_file }}
