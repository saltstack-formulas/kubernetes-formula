# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.os_family == 'MacOS' %}

{{ formula }}-kubectl-package-clean-brew:
  cmd.run:
    - names:
      - brew uninstall {{ d.kudo.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - onlyif:
      - test -x /usr/local/bin/brew
      - brew list | grep {{ d.kubectl.pkg.name }}

    {%- elif grains.kernel|lower == 'linux' %}

{{ formula }}-kubectl-package-clean-kubectl-krew:
  cmd.run:
    - name: kubectl krew uninstall {{ d.kubectl.pkg.name }}
    - onlyif: test -x /usr/local/bin/kubectl

    {%- endif %}
