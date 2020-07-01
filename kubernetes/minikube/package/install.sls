# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

    {%- if grains.kernel|lower in ('linux',) %}
           {%- if k8s.minikube.pkg.use_upstream_repo %}
include:
  - .repo
           {%- endif %}

k8s-minikube-package-install-deps-installed:
  pkg.installed:
    - names: {{ k8s.minikube.pkg.deps|json }}

k8s-minikube-package-install-pkg-installed:
  pkg.installed:
    - name: {{ k8s.minikube.pkg.name }}
    - reload_modules: true
        {%- if k8s.minikube.pkg.use_upstream_repo %}
    - require:
      - pkgrepo: k8s-minikube-package-repo-pkgrepo-managed
        {%- endif %}

    {%- elif grains.os_family == 'MacOS' %}

k8s-minikube-package-install-cmd-run-brew:
  cmd.run:
    - name: brew install {{ k8s.minikube.pkg.name }}
    - runas: {{ k8s.rootuser }}
    - onlyif: test -x /usr/local/bin/brew

k8s-minikube-package-reinstall-cmd-run-brew:
  cmd.run:
    - name: brew reinstall {{ k8s.minikube.pkg.name }}
    - runas: {{ k8s.rootuser }}
    - unless: test -x /usr/local/bin/minikube  # if corruption detected

    {%- elif grains.kernel|lower == 'linux' %}

k8s-minikube-package-install-cmd-run-snap:
  pkg.installed:
    - name: snapd
  service.running:
    - name: snapd
  cmd.run:
    - name: snap install {{ k8s.minikube.pkg.name }} --classic
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap
    - require:
      - service: k8s-minikube-package-install-cmd-run-snap

    {%- endif %}
