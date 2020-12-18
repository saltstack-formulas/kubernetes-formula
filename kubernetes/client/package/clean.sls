# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.client.pkg.use_upstream in ('package', 'repo') %}
        {%- if grains.kernel|lower in ('linux',) %}

            {%- if d.client.pkg.use_upstream == 'repo' %}
include:
  - .package.repo.clean
            {%- endif %}

kubernetes-client-package-clean-pkg:
  pkg.removed:
    - name: kubectl
    - reload_modules: true
            {%- if d.client.pkg.use_upstream == 'repo' %}
    - require:
      - pkgrepo: kubernetes-package-repo-absent
            {%- endif %}

        {%- elif grains.os_family == 'MacOS' %}

kubernetes-client-package-clean-brew:
  cmd.run:
    - name:  /usr/local/bin/brew uninstall kubectl
    - runas: {{ d.identity.rootuser }}
    - onlyif:
      - test -x /usr/local/bin/brew
      - brew list | grep ^kubectl$

        {%- elif grains.os_family == 'Windows' %}

kubernetes-client-package-clean-choco:
  chocolatey.uninstalled:
    - name: {{ d.client.pkg.name }}

        {%- endif %}
    {%- endif %}
