# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-minikube-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/minikube
           {%- if d.minikube.pkg.use_upstream_binary and d.minikube.pkg.binary.name %}
      - {{ d.minikube.pkg.binary.name }}/
           {%- endif %}
