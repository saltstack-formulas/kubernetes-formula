# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

    {%- if grains.kernel|lower in ('linux',) %}
           {%- if k8s.kubectl.pkg.use_upstream_repo %}
include:
  - .repo
           {%- endif %}

k8s-kubectl-package-install-deps-installed:
  pkg.installed:
    - names: {{ k8s.kubectl.pkg.deps|json }}

k8s-kubectl-package-install-pkg-installed:
  pkg.installed:
    - name: {{ k8s.kubectl.pkg.name }}
    - runas: {{ k8s.rootuser }}
    - reload_modules: true
        {%- if k8s.kubectl.pkg.use_upstream_repo %}
    - require:
      - pkgrepo: k8s-kubectl-package-repo-pkgrepo-managed
        {%- endif %}

    {%- elif grains.os_family == 'MacOS' %}

k8s-kubectl-package-install-cmd-run-brew:
  cmd.run:
    - name: brew install {{ k8s.kubectl.pkg.name }}
    - runas: {{ k8s.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

k8s-kubectl-package-reinstall-cmd-run-brew:
  cmd.run:
    - name: brew reinstall {{ k8s.kubectl.pkg.name }}
    - runas: {{ k8s.rootuser }}
    - unless: test -x /usr/local/bin/kubectl  # if binary is missing

    {%- elif grains.kernel|lower == 'linux' %}

k8s-kubectl-package-install-cmd-run-snap:
  pkg.installed:
    - name: snapd
  service.running:
    - name: snapd
  cmd.run:
    - name: snap install {{ k8s.kubectl.pkg.name }} --classic
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap
    - require:
      - service: k8s.kubectl-package-install-cmd-run-snap

    {%- endif %}
