# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.client.pkg.use_upstream in ('package', 'repo') %}
        {%- if grains.kernel|lower in ('linux',) %}

            {%- if d.client.pkg.use_upstream == 'repo' %}
include:
  - .package.repo.clean
            {%- endif %}

{{ formula }}-client-package-clean-pkg:
  pkg.removed:
    - name: kubectl
    - reload_modules: true
            {%- if d.client.pkg.use_upstream == 'repo' %}
    - require:
      - pkgrepo: {{ formula }}-package-repo-absent
            {%- endif %}

        {%- elif grains.os_family == 'MacOS' %}

{{ formula }}-client-package-clean-brew:
  cmd.run:
    - name:  /usr/local/bin/brew uninstall kubectl
    - runas: {{ d.identity.rootuser }}
    - onlyif:
      - test -x /usr/local/bin/brew
      - grew list | grep ^kubectl$

        {%- elif grains.os_family == 'Windows' %}

{{ formula }}-client-package-clean-choco:
  chocolatey.uninstalled:
    - name: {{ d.client.pkg.name }}

        {%- endif %}
    {%- endif %}
