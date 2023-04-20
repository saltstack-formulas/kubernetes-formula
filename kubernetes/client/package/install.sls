# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.client.pkg.use_upstream in ('package', 'repo') %}

        {%- if grains.kernel|lower in ('linux',) %}
            {%- if d.client.pkg.use_upstream == 'repo' %}
              {%- set sls_repo_install = tplroot ~ '.package.repo.install' %}
include:
  - {{ sls_repo_install }}
            {%- endif %}

kubernetes-client-package-install-deps:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - pkg: kubernetes-client-package-install-pkg

kubernetes-client-package-install-pkg:
  pkg.installed:
    - name: {{ d.client.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - reload_modules: true
            {%- if d.client.pkg.use_upstream == 'repo' %}
    - require:
      - pkgrepo: kubernetes-package-repo-managed
            {%- endif %}

        {%- elif grains.kernel|lower in ('MacOS',) %}

kubernetes-client-package-install-brew:
  cmd.run:
    - name: /usr/local/bin/brew install {{ d.client.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - onlyif:
      - test -x /usr/local/bin/brew

kubernetes-client-package-reinstall-brew:
  cmd.run:
    - name: /usr/local/bin/brew reinstall kubectl
    - runas: {{ d.identity.rootuser }}
    - unless: test -x /usr/local/bin/kubectl  # if binary is missing

        {%- elif grains.kernel|lower in ('windows',) %}

kubernetes-client-package-install-choco:
  chocolatey.installed:
    - name: {{ d.client.pkg.name }}
    - force: True

        {%- endif %}
    {%- endif %}
