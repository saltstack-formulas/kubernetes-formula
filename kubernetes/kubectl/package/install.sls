# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower in ('linux',) %}
        {%- if d.kubectl.pkg.use_upstream_repo %}
include:
  - .repo
        {%- endif %}

{{ formula }}-kubectl-package-install-deps:
  pkg.installed:
    - names: {{ d.kubectl.pkg.deps|json }}

{{ formula }}-kubectl-package-install-pkg:
  pkg.installed:
    - name: {{ d.kubectl.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - reload_modules: true
        {%- if d.kubectl.pkg.use_upstream_repo %}
    - require:
      - pkgrepo: {{ formula }}-kubectl-package-repo-managed
        {%- endif %}

    {%- elif grains.os_family == 'MacOS' %}

{{ formula }}-kubectl-package-install-brew:
  cmd.run:
    - name: /usr/local/bin/brew install {{ d.kubectl.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

{{ formula }}-kubectl-package-reinstall-brew:
  cmd.run:
    - name: /usr/local/bin/brew reinstall {{ d.kubectl.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - unless: test -x /usr/local/bin/kubectl  # if binary is missing

    {%- elif grains.kernel|lower == 'linux' %}

{{ formula }}-kubectl-package-install-snap:
  pkg.installed:
    - name: snapd
  service.running:
    - name: snapd
  cmd.run:
    - name: snap install {{ d.kubectl.pkg.name }} --classic
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap
    - require:
      - service: d.kubectl-package-install-cmd-run-snap

    {%- endif %}
