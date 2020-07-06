# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

        {%- if not d.devspace.pkg.use_upstream_repo and d.linux.altpriority|int > 0 %}
            {%- set sls_binary_clean = tplroot ~ '.devspace.binary.clean' %}

include:
  - {{ sls_binary_clean }}

{{ formula }}-devspace-config-alternatives-remove:
  alternatives.remove:
    - name: link-k8s-devspace
    - path: {{ d.devspace.pkg.binary.name }}/bin/devspace
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-devspace
    - require:
      - sls: {{ sls_binary_clean }}
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ d.devspace.pkg.use_upstream_repo }}

        {%- endif %}
    {%- endif %}
