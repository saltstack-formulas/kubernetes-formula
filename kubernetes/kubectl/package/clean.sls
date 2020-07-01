# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

    {%- if grains.kernel|lower in ('linux',) %}
           {%- if k8s.kubectl.pkg.use_upstream_repo %}
include:
  - .repo.clean
           {%- endif %}

k8s-kubectl-package-clean-pkg-cleaned:
  pkg.removed:
    - name: {{ k8s.kubectl.pkg.name }}
    - reload_modules: true
        {%- if k8s.kubectl.pkg.use_upstream_repo %}
    - require:
      - pkgrepo: k8s-kubectl-package-repo-pkgrepo-absent
        {%- endif %}

    {%- elif grains.os_family == 'MacOS' %}

k8s-kubectl-package-clean-cmd-run-brew:
  cmd.run:
    - name:  brew uninstall {{ k8s.minikube.pkg.name }} {{ k8s.kubectl.pkg.name }}
    - runas: {{ k8s.rootuser }}
    - onlyif:
      - test -x /usr/local/bin/brew
      - grew list | grep {{ k8s.kubectl.pkg.name }}

    {%- elif grains.kernel|lower == 'linux' %}

k8s-kubectl-package-clean-cmd-run-snap:
  cmd.run:
    - name: snap remove {{ k8s.kubectl.pkg.name }}
    - onlyif: test -x /usr/bin/snap || test -x /usr/local/bin/snap

    {%- endif %}
