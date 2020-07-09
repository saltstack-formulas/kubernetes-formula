# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.os_family == 'MacOS' %}

{{ formula }}-kudo-package-install-brew:
  cmd.run:
    - names:
      - /usr/local/bin/brew tap install {{ d.kudo.pkg.tapname }}
      - /usr/local/bin/brew install kudo

{{ formula }}-kudo-package-reinstall-brew:
  cmd.run:
    - name: /usr/local/bin/brew reinstall kudo
    - runas: {{ d.identity.rootuser }}
    - unless: test -x /usr/local/bin/kudo  # if binary is missing

    {%- elif grains.kernel|lower == 'linux' %}

{{ formula }}-kudo-package-install-krew:
  cmd.run:
    - name: kubectl krew install kudo

    {%- endif %}

{{ formula }}-kudo-package-kubectl-kudo-init:
  cmd.run:
    - name: kubectl kudo init
    - runas: {{ d.identity.rootuser }}
    - onlyif: test -x /usr/local/bin/kubectl
