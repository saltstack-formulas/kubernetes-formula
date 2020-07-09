# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-minikube-binary-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
  file.directory:
    - name: {{ d.minikube.pkg.binary.name }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-minikube-binary-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ d.minikube.pkg.binary.name }}/bin/minikube {{ d.minikube.pkg.binary.source }}
      - chmod '0755' {{ d.minikube.pkg.binary.name }}/bin/minikube 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
      {%- if 'source_hash' in d.minikube.pkg.binary and d.minikube.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ d.minikube.pkg.binary.name }}/bin/minikube
    - file_hash: {{ d.minikube.pkg.binary.source_hash }}
    - require:
      - cmd: {{ formula }}-minikube-binary-install
      {%- endif %}

{{ formula }}-minikube-binary-install-symlink:
  file.symlink:
    - name: /usr/local/bin/minikube
    - target: {{ d.minikube.pkg.binary.name }}/bin/minikube
    - force: True
    - require:
      - cmd: {{ formula }}-minikube-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}
