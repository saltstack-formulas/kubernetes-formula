# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-k3s-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/k3s
           {%- if d.k3s.pkg.use_upstream_binary and d.k3s.pkg.binary.name %}
      - {{ d.k3s.pkg.binary.name }}/
           {%- endif %}
