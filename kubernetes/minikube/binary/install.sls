# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

k8s-minikube-release-binary-install-file-directory:
  file.directory:
    - name: {{ k8s.minikube.pkg.binary.basedir }}/bin
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: k8s-minikube-release-binary-install-cmd-run
    - recurse:
        - user
        - group
        - mode

k8s-minikube-release-binary-install-cmd-run:
  cmd.run:
    - names:
      - curl -Lo {{ k8s.minikube.pkg.binary.basedir }}/bin/minikube {{ k8s.minikube.pkg.binary.source }}
      - chmod '0755' {{ k8s.minikube.pkg.binary.basedir }}/bin/minikube 2>/dev/null
    - retry: {{ k8s.retry_option }}
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
      {%- if 'source_hash' in k8s.minikube.pkg.binary and k8s.minikube.pkg.binary.source_hash %}
  module.run:
    - name: file.check_hash
    - path: {{ k8s.minikube.pkg.binary.basedir }}/bin/minikube
    - file_hash: {{ k8s.minikube.pkg.binary.source_hash }}
    - require:
      - cmd: k8s-minikube-release-binary-install-cmd-run
      {%- endif %}

      {%- if k8s.minikube.linux.altpriority|int == 0 and k8s.kernel == 'linux' %}
k8s-minikube-release-binary-install-file-symlink:
  file.symlink:
    - name: /usr/local/bin/minikube
    - target: {{ k8s.minikube.pkg.binary.basedir }}/bin/minikube
    - force: True
    - backupname: salt.bak
    - onlyif: {{ k8s.kernel not in ('windows',) }}
    - require:
      - cmd: k8s-minikube-release-binary-install-cmd-run
      {%- endif %}
