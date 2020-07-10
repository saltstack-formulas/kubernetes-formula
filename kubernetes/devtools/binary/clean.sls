# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-devtools-stern-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/stern
      - {{ d.devtools.stern.pkg.binary.name }}/bin/stern
