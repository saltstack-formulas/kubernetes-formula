# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-linkerd2-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/linkerd
      - {{ d.linkerd2.pkg.binary.name }}/bin/linkerd
