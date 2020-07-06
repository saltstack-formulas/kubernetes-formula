# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-kubectl-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/kubectl
           {%- if d.kubectl.pkg.use_upstream_binary and d.kubectl.pkg.binary.name %}
      - {{ d.kubectl.pkg.binary.name }}/bin/kubectl
           {%- endif %}
