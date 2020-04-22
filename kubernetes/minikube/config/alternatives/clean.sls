# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}

        {%- if not k8s.minikube.pkg.use_upstream_repo and k8s.minikube.linux.altpriority|int > 0 %}

include:
  - {{ tplroot ~ '.minikube.package.clean' }}
  - {{ tplroot ~ '.minikube.source.clean' }}
  - {{ tplroot ~ '.minikube.binary.clean' }}

k8s-minikube-config-alternatives-clean-k8s-minikube-alternative-remove:
  alternatives.remove:
    - name: link-k8s-minikube
    - path: {{ k8s.minikube.pkg.binary.name }}/bin/minikube
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-minikube
    - require:
      - sls: {{ tplroot ~ '.minikube.package.clean' }}
      - sls: {{ tplroot ~ '.minikube.source.clean' }}
      - sls: {{ tplroot ~ '.minikube.binary.clean' }}
    - unless:
      - {{ grains.os_family in ('Suse','Arch') }}
      - {{ k8s.minikube.pkg.use_upstream_repo }}

        {%- endif %}
  {%- endif %}
