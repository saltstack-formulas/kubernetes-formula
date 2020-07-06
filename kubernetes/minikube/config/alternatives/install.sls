# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

        {%- if not d.minikube.pkg.use_upstream_repo and d.linux.altpriority|int > 0 %}
            {%- set sls_binary_install = tplroot ~ '.minikube.binary.install' %}
            {%- set sls_package_install = tplroot ~ '.minikube.package.install' %}

include:
  - {{ sls_binary_install if d.minikube.pkg.use_upstream_binary else sls_package_install }}

{{ formula }}-minikube-config-alternatives-install:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse','Arch') }}
      - {{ d.minikube.pkg.use_upstream_repo }}
    - name: link-k8s-minikube
    - link: /usr/local/bin/minikube
    - path: {{ d.minikube.pkg.binary.name }}/bin/minikube
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_binary_install if d.minikube.pkg.use_upstream_binary else sls_package_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/minikube link-k8s-minikube {{ d.minikube.pkg.binary.name }}/bin/minikube {{ d.linux.altpriority }}  # noqa 204

{{ formula }}-minikube-config-alternatives-set:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse',) }}
    - name: link-k8s-minikube
    - path: {{ d.minikube.pkg.binary.name }}/bin/minikube
    - require:
      - alternatives: k8s-minikube-config-alternatives-install
      - sls: {{ sls_binary_install if d.minikube.pkg.use_upstream_binary else sls_package_install }}
    - unless:
      - {{ grains.os_family in ('Suse','Arch') }}
      - {{ d.minikube.pkg.use_upstream_repo }}

        {%- endif %}
    {%- endif %}
