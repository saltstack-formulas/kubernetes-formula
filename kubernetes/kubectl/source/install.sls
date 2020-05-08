# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

k8s-kubectl-release-source-install:
  pkg.installed:
    - names: {{ k8s.kubectl.pkg.deps|json }}
  file.directory:
    - name: {{ k8s.kubectl.pkg.source.name }}
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - archive: k8s-kubectl-release-source-install
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    {{- format_kwargs(k8s.kubectl.pkg.source) }}
    - retry: {{ k8s.retry_option|json }}
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - recurse:
        - user
        - group
  cmd.run:
    - cwd: {{ k8s.kubectl.pkg.source.name }}
    - names:
      - echo "figure out how to build from source code tarball"
    - unless:
      - test -f /usr/local/bin/kubectl
    - require:
      - archive: k8s-kubectl-release-source-install
