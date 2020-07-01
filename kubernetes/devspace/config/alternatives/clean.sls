# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_clean = tplroot ~ '.devspace.binary.clean' %}

         {%- if not k8s.devspace.pkg.use_upstream_repo and k8s.devspace.linux.altpriority|int > 0 %}

include:
  - {{ sls_binary_clean }}

k8s-devspace-config-alternatives-clean-k8s-devspace-alternative-remove:
  alternatives.remove:
    - name: link-k8s-devspace
    - path: {{ k8s.devspace.pkg.binary.name }}/bin/devspace
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-devspace
    - require:
      - sls: {{ sls_binary_clean }}
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ k8s.devspace.pkg.use_upstream_repo }}

        {%- endif %}
  {%- endif %}
