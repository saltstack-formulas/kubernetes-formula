# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower in ('linux',) %}
        {%- if d.client.pkg.use_upstream_repo %}
            {%- set sls_repo_install = tplroot ~ '.package.repo.install' %}
include:
  - {{ sls_repo_install }}
        {%- endif %}

{{ formula }}-client-package-install-deps:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}

{{ formula }}-client-package-install-pkg:
  pkg.installed:
    - name: {{ d.client.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - reload_modules: true
        {%- if d.client.pkg.use_upstream_repo %}
    - require:
      - pkgrepo: {{ formula }}-package-repo-managed
        {%- endif %}

    {%- elif grains.os_family == 'MacOS' %}

{{ formula }}-client-package-install-brew:
  cmd.run:
    - name: /usr/local/bin/brew install {{ d.client.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

{{ formula }}-client-package-reinstall-brew:
  cmd.run:
    - name: /usr/local/bin/brew reinstall kubectl
    - runas: {{ d.identity.rootuser }}
    - unless: test -x /usr/local/bin/kubectl  # if binary is missing

    {%- elif grains.kernel|lower == 'linux' %}

{{ formula }}-client-package-install-snap:
  pkg.installed:
    - name: snapd
  service.running:
    - name: snapd
  cmd.run:
    - name: snap install {{ d.client.pkg.name }} --classic
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap
    - require:
      - service: {{ formula }}-client-package-install-snap

    {%- endif %}
