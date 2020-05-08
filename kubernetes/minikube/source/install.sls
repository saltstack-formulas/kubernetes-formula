# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

k8s-minikube-release-source-install:
  pkg.installed:
    - names: {{ k8s.minikube.pkg.deps|json }}
  file.directory:
    - name: {{ k8s.minikube.pkg.source.name }}
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - archive: k8s-minikube-release-source-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(k8s.minikube.pkg.source) }}
    - retry: {{ k8s.retry_option|json|json }}
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - recurse:
        - user
        - group
  cmd.run:
    - cwd: {{ k8s.minikube.pkg.source.name }}
    - names:
      - echo "figure out how to build from source code tarball"
    - unless:
      - test -f /usr/local/bin/minikube
    - require:
      - archive: k8s-minikube-release-source-install
