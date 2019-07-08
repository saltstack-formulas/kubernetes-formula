# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_install = tplroot ~ '.kubectl.binary.install' %}
{%- set sls_package_install = tplroot ~ '.kubectl.package.install' %}
{%- set sls_source_install = tplroot ~ '.kubectl.source.install' %}

  {%- if k8s.kernel == 'linux' and k8s.kubectl.linux.altpriority|int > 0 %}

include:
  {{ '- ' + sls_package_install if k8s.kubectl.pkg.use_upstream_repo }}
  {{ '- ' + sls_source_install if k8s.kubectl.pkg.use_upstream_source }}
  {{ '- ' + sls_binary_install if k8s.kubectl.pkg.use_upstream_binary }}

k8s-kubectl-config-alternatives-install-k8s-kubectl-alternative-install:
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/kubectl link-k8s-kubectl {{ k8s.kubectl.pkg.binary.basedir }}/bin/kubectl {{ k8s.kubectl.linux.altpriority }}
  alternatives.install:
    - name: link-k8s-kubectl
    - link: /usr/local/bin/kubectl
    - path: {{ k8s.kubectl.pkg.binary.basedir }}/bin/kubectl
    - priority: {{ k8s.kubectl.linux.altpriority }}
    - order: 10
    - require:
      {{ '- sls: ' + sls_package_install if k8s.kubectl.pkg.use_upstream_repo }}
      {{ '- sls: ' + sls_source_install if k8s.kubectl.pkg.use_upstream_source }}
      {{ '- sls: ' + sls_binary_install if k8s.kubectl.pkg.use_upstream_binary }}
    - unless: {{ grains.os_family in ('Suse',) }}

k8s-kubectl-config-alternatives-install-k8s.kubectl-alternative-set:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse',) }}
    - name: link-k8s-kubectl
    - path: {{ k8s.kubectl.pkg.binary.basedir }}/bin/kubectl
    - require:
      - alternatives: k8s-kubectl-config-alternatives-install-k8s-kubectl-alternative-install
      {{ '- sls: ' + sls_package_install if k8s.kubectl.pkg.use_upstream_repo }}
      {{ '- sls: ' + sls_source_install if k8s.kubectl.pkg.use_upstream_source }}
      {{ '- sls: ' + sls_binary_install if k8s.kubectl.pkg.use_upstream_binary }}

  {%- endif %}
