# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.os_family == 'MacOS' %}
        {%- set tplroot = tpldir.split('/')[0] %}
        {%- from tplroot ~ "/map.jinja" import data as d with context %}
        {%- set formula = d.formula %}


{{ formula }}-kind-package-install-brew:
  cmd.run:
    - names:
      - /usr/local/bin/brew install {{ d.kind.pkg.name }}

{{ formula }}-kind-package-reinstall-brew:
  cmd.run:
    - name: /usr/local/bin/brew reinstall {{ d.kind.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - unless: test -x /usr/local/bin/kind  # if binary is missing

    {%- endif %}

