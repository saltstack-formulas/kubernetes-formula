# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower in ('linux',) %}
        {%- if d.minikube.pkg.use_upstream_repo %}
include:
  - .repo
        {%- endif %}

{{ formula }}-minikube-package-install-deps:
  pkg.installed:
    - names: {{ d.minikube.pkg.deps|json }}

{{ formula }}-minikube-package-installed:
  pkg.installed:
    - name: {{ d.minikube.pkg.name }}
    - reload_modules: true
        {%- if d.minikube.pkg.use_upstream_repo %}
    - require:
      - pkgrepo: {{ formula }}-minikube-package-repo-managed
        {%- endif %}

    {%- elif grains.os_family == 'MacOS' %}

{{ formula }}-minikube-package-install-brew:
  cmd.run:
    - name: brew install {{ d.minikube.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

{{ formula }}-minikube-package-reinstall-brew:
  cmd.run:
    - name: brew reinstall {{ d.minikube.pkg.name }}
    - runas: {{ d.identity.rootuser }}
    - unless: test -x /usr/local/bin/minikube  # if corruption detected

    {%- elif grains.kernel|lower == 'linux' %}

{{ formula }}-minikube-package-install-snap:
  pkg.installed:
    - name: snapd
  service.running:
    - name: snapd
  cmd.run:
    - name: snap install {{ d.minikube.pkg.name }} --classic
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap
    - require:
      - service: {{ formula }}-minikube-package-install-snap

    {%- endif %}
