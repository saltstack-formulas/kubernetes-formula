# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}
        {%- if d.istio.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}

include:
  - {{ sls_archive_clean }}

{{ formula }}-istio-archive-alternatives-remove:
  alternatives.remove:
    - name: link-k8s-istio
    - path: {{ d.istio.pkg.archive.name }}/bin/istio
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-istio
    - require:
      - sls: {{ sls_archive_clean }}
    - unless:
      - {{ grains.os_family in ('Arch',) }}

        {%- endif %}
    {%- endif %}
