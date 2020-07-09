# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.os_family == 'MacOS' %}

{{ formula }}-kudo-package-clean-brew:
  cmd.run:
    - names:
      - /usr/local/bin/brew uninstall kudo
    - runas: {{ d.identity.rootuser }}
    - onlyif:
      - test -x /usr/local/bin/brew
      - /usr/local/bin/brew list | grep kudo

    {%- elif grains.kernel|lower == 'linux' %}

{{ formula }}-kudo-package-clean-kudo-krew:
  cmd.run:
    - name: kubectl krew uninstall kudo
    - onlyif: test -x /usr/local/bin/kudo

    {%- endif %}
