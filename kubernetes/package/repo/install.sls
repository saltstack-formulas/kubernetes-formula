# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

    {%- if 'repo' in k8s.pkg and k8s.pkg.repo %}
        {%- if grains.os_family|lower in ('redhat', 'debian') %}
            {%- from tplroot ~ "/jinja/macros.jinja" import format_kwargs with context %}

k8s-package-repo-install-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(k8s.pkg.repo) }}
    - require_in:
      - file: k8s-package-repo-install-file-replace

        {%- endif %}

k8s-package-repo-install-file-replace:
  # redhat workaround for salt issue #51494
  file.replace:
    - name: /etc/yum.repos.d/kubernetes.repo
    - pattern: ' gpgkey2='
    - repl: '\n       '
    - ignore_if_missing: True
    - onlyif: test -f /etc/yum.repos.d/kubernetes.repo

    {%- endif %}
