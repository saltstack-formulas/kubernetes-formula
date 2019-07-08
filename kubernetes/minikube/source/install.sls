# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- from tplroot ~ "/jinja/macros.jinja" import format_kwargs with context %}

k8s-minikube-release-source-install-file-directory:
  file.directory:
    - name: {{ k8s.minikube.pkg.source.name }}
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - source: k8s-minikube-release-source-install-source-extracted
    - recurse:
        - user
        - group
        - mode

k8s-minikube-release-source-install-source-extracted:
  archive.extracted:
    {{- format_kwargs(k8s.minikube.pkg.source) }}
    - retry: {{ k8s.retry_option }}
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - recurse:
        - user
        - group

k8s-minikube-release-source-install-cmd-run-make-install:
  cmd.run:
    - cwd: {{ k8s.minikube.pkg.source.name }}
    - names:
      - echo "figure out how to build from source code tarball"
    - unless:
      - test -f /usr/local/bin/minikube
    - require:
      - archive: k8s-minikube-release-source-install-source-extracted
