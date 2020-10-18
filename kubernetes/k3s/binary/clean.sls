# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-k3s-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/k3s
      - "{{ d.k3s.pkg.path }}"
  module.run:
    - name: file.find
    - path: "{{ d.dir.base }}"
    - kwargs:
        iname: "k8s-k3s-v*"
        delete: "d"
