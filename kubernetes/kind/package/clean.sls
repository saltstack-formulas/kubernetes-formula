# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}
        {%- set tplroot = tpldir.split('/')[0] %}
        {%- from tplroot ~ "/map.jinja" import data as d with context %}
        {%- set formula = d.formula %}

{{ formula }}-kind-package-clean-brew:
  cmd.run:
    - names:
      - /usr/local/bin/brew uninstall {{ d.kind.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - onlyif:
      - test -x /usr/local/bin/brew
      - /usr/local/bin/brew list | grep ^{{ d.kind.pkg.name }}

    {%- endif %}
