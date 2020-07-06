# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-devspace-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/devspace
           {%- if d.devspace.pkg.use_upstream_binary and d.devspace.pkg.binary.name %}
      - {{ d.devspace.pkg.binary.name }}/
           {%- endif %}
