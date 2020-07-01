# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_install = tplroot ~ '.kubectl.binary.install' %}
{%- set sls_package_install = tplroot ~ '.kubectl.package.install' %}
{%- set sls_source_install = tplroot ~ '.kubectl.source.install' %}

        {%- if not k8s.kubectl.pkg.use_upstream_repo and k8s.kubectl.linux.altpriority|int > 0 %}

include:
  {{ '- ' + sls_package_install if k8s.kubectl.pkg.use_upstream_repo else '' }}
  {{ '- ' + sls_source_install if k8s.kubectl.pkg.use_upstream_source else '' }}
  {{ '- ' + sls_binary_install if k8s.kubectl.pkg.use_upstream_binary else '' }}

k8s-kubectl-config-alternatives-install-k8s-kubectl-alternative-install:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ k8s.kubectl.pkg.use_upstream_repo }}
    - name: link-k8s-kubectl
    - link: /usr/local/bin/kubectl
    - path: {{ k8s.kubectl.pkg.binary.name }}/bin/kubectl
    - priority: {{ k8s.kubectl.linux.altpriority }}
    - order: 10
    - require:
      {{ '- sls: ' + sls_package_install if k8s.kubectl.pkg.use_upstream_repo else '' }}
      {{ '- sls: ' + sls_source_install if k8s.kubectl.pkg.use_upstream_source else '' }}
      {{ '- sls: ' + sls_binary_install if k8s.kubectl.pkg.use_upstream_binary else '' }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/kubectl link-k8s-kubectl {{ k8s.kubectl.pkg.binary.name }}/bin/kubectl {{ k8s.kubectl.linux.altpriority }} # noqa 204

k8s-kubectl-config-alternatives-install-k8s.kubectl-alternative-set:
  alternatives.set:
    - unless:
      # {{ grains.os in ('Debian',) }}
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ k8s.kubectl.pkg.use_upstream_repo }}
    - name: link-k8s-kubectl
    - path: {{ k8s.kubectl.pkg.binary.name }}/bin/kubectl
    - require:
      - alternatives: k8s-kubectl-config-alternatives-install-k8s-kubectl-alternative-install
      {{ '- sls: ' + sls_package_install if k8s.kubectl.pkg.use_upstream_repo else '' }}
      {{ '- sls: ' + sls_source_install if k8s.kubectl.pkg.use_upstream_source else '' }}
      {{ '- sls: ' + sls_binary_install if k8s.kubectl.pkg.use_upstream_binary else '' }}

        {%- endif %}
  {%- endif %}
