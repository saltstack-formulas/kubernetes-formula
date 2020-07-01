# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-devspace-release-binary-install:
  pkg.installed:
    - names: {{ k8s.devspace.pkg.deps|json }}
  file.directory:
    - name: {{ k8s.devspace.pkg.binary.name }}/bin
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: k8s-devspace-release-binary-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ k8s.devspace.pkg.binary.name }}/bin/devspace {{ k8s.devspace.pkg.binary.source }}
      - chmod '0755' {{ k8s.devspace.pkg.binary.name }}/bin/devspace 2>/dev/null
    - retry: {{ k8s.retry_option|json }}
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
      {%- if 'source_hash' in k8s.devspace.pkg.binary and k8s.devspace.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ k8s.devspace.pkg.binary.name }}/bin/devspace
    - file_hash: {{ k8s.devspace.pkg.binary.source_hash }}
    - require:
      - cmd: k8s-devspace-release-binary-install
      {%- endif %}

k8s-devspace-release-binary-install-file-symlink:
  file.symlink:
    - name: {{ k8s.devspace.linux.symlink }}
    - target: {{ k8s.devspace.pkg.binary.name }}/bin/{{ k8s.devspace.pkg.name }}
    - force: True
    - require:
      - cmd: k8s-devspace-release-binary-install
    - unless:
      - {{ k8s.devspace.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows', 'arch') }}
