# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

kubernetes-client-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/kubectl
      - {{ d.client.pkg.path }}
