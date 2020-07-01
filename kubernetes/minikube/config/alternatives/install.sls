# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_install = tplroot ~ '.minikube.binary.install' %}
{%- set sls_package_install = tplroot ~ '.minikube.package.install' %}
{%- set sls_source_install = tplroot ~ '.minikube.source.install' %}

        {%- if not k8s.minikube.pkg.use_upstream_repo and k8s.minikube.linux.altpriority|int > 0 %}

include:
  {{ '- ' + sls_package_install if k8s.minikube.pkg.use_upstream_repo else '' }}
  {{ '- ' + sls_source_install if k8s.minikube.pkg.use_upstream_source else '' }}
  {{ '- ' + sls_binary_install if k8s.minikube.pkg.use_upstream_binary else '' }}

k8s-minikube-config-alternatives-install-k8s-minikube-alternative-install:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse','Arch') }}
      - {{ k8s.minikube.pkg.use_upstream_repo }}
    - name: link-k8s-minikube
    - link: /usr/local/bin/minikube
    - path: {{ k8s.minikube.pkg.binary.name }}/bin/minikube
    - priority: {{ k8s.minikube.linux.altpriority }}
    - order: 10
    - require:
      {{ '- sls: ' + sls_package_install if k8s.minikube.pkg.use_upstream_repo else '' }}
      {{ '- sls: ' + sls_source_install if k8s.minikube.pkg.use_upstream_source else '' }}
      {{ '- sls: ' + sls_binary_install if k8s.minikube.pkg.use_upstream_binary else '' }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/minikube link-k8s-minikube {{ k8s.minikube.pkg.binary.name }}/bin/minikube {{ k8s.minikube.linux.altpriority }}  # noqa 204

k8s-minikube-config-alternatives-install-k8s.minikube-alternative-set:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse',) }}
    - name: link-k8s-minikube
    - path: {{ k8s.minikube.pkg.binary.name }}/bin/minikube
    - require:
      - alternatives: k8s-minikube-config-alternatives-install-k8s-minikube-alternative-install
      {{ '- sls: ' + sls_package_install if k8s.minikube.pkg.use_upstream_repo else '' }}
      {{ '- sls: ' + sls_source_install if k8s.minikube.pkg.use_upstream_source else '' }}
      {{ '- sls: ' + sls_binary_install if k8s.minikube.pkg.use_upstream_binary else '' }}
    - unless:
      - {{ grains.os_family in ('Suse','Arch') }}
      - {{ k8s.minikube.pkg.use_upstream_repo }}

        {%- endif %}
  {%- endif %}
