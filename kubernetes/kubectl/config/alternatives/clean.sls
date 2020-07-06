# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

        {%- if not d.kubectl.pkg.use_upstream_repo and d.linux.altpriority|int > 0 %}
            {%- set sls_binary_clean = tplroot ~ '.kubectl.binary.clean' %}
            {%- set sls_package_clean = tplroot ~ '.kubectl.package.clean' %}

include:
  - {{ sls_package_clean }}
  - {{ sls_binary_clean }}

{{ formula }}-kubectl-config-alternatives-remove:
  alternatives.remove:
    - name: link-k8s-kubectl
    - path: {{ d.kubectl.pkg.binary.name }}/bin/kubectl
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-kubectl
    - require:
      - sls: {{ sls_package_clean }}
      - sls: {{ sls_binary_clean }}
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ d.kubectl.pkg.use_upstream_repo }}

        {%- endif %}
    {%- endif %}
