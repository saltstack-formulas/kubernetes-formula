# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}
        {%- if d.kubebuilder.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}

include:
  - {{ sls_archive_clean }}

{{ formula }}-kubebuilder-archive-alternatives-remove:
  alternatives.remove:
    - name: link-k8s-kubebuilder
    - path: {{ d.kubebuilder.pkg.archive.name }}/bin/kubebuilder
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-kubebuilder
    - require:
      - sls: {{ sls_archive_clean }}
    - unless:
      - {{ grains.os_family in ('Arch',) }}

        {%- endif %}
    {%- endif %}
