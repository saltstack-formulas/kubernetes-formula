# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.client.pkg.use_upstream in ('package', 'repo') %}

        {%- if grains.kernel|lower in ('linux',) %}
            {%- if d.client.pkg.use_upstream == 'repo' %}
include:
  - .package.repo.install
            {%- endif %}

{{ formula }}-client-package-install-deps:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - pkg: {{ formula }}-client-package-install-pkg

{{ formula }}-client-package-install-pkg:
  pkg.installed:
    - name: {{ d.client.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - reload_modules: true
            {%- if d.client.pkg.use_upstream == 'repo' %}
    - require:
      - pkgrepo: {{ formula }}-package-repo-managed
            {%- endif %}

        {%- elif grains.kernel|lower in ('MacOS',) %}

{{ formula }}-client-package-install-brew:
  cmd.run:
    - name: /usr/local/bin/brew install {{ d.client.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - onlyif:
      - test -x /usr/local/bin/brew

{{ formula }}-client-package-reinstall-brew:
  cmd.run:
    - name: /usr/local/bin/brew reinstall kubectl
    - runas: {{ d.identity.rootuser }}
    - unless: test -x /usr/local/bin/kubectl  # if binary is missing

        {%- elif grains.kernel|lower in ('windows',) %}

{{ formula }}-client-package-install-choco:
  chocolatey.installed:
    - name: {{ d.client.pkg.name }}
    - force: True

        {%- endif %}
    {%- endif %}
