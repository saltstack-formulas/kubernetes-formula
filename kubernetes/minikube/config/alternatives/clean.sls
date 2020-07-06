# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

        {%- if not d.minikube.pkg.use_upstream_repo and d.linux.altpriority|int > 0 %}
            {%- set sls_binary_clean = tplroot ~ '.minikube.binary.clean' %}
            {%- set sls_package_clean = tplroot ~ '.minikube.package.clean' %}

include:
  - {{ sls_binary_clean }}
  - {{ sls_package_clean }}

{{ formula }}-minikube-config-alternatives-clean:
  alternatives.remove:
    - name: link-k8s-minikube
    - path: {{ d.minikube.pkg.binary.name }}/bin/minikube
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-minikube
    - require:
      - sls: {{ sls_binary_clean }}
      - sls: {{ sls_package_clean }}
    - unless:
      - {{ grains.os_family in ('Suse','Arch') }}
      - {{ d.minikube.pkg.use_upstream_repo }}

        {%- endif %}
    {%- endif %}
