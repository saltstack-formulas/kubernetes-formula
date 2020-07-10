# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}
        {%- if d.krew.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}

include:
  - {{ sls_archive_clean }}

{{ formula }}-krew-archive-alternatives-remove:
  alternatives.remove:
    - name: link-k8s-krew
    - path: {{ d.krew.pkg.archive.name }}/bin/krew
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-krew
    - require:
      - sls: {{ sls_archive_clean }}
    - unless:
      - {{ grains.os_family in ('Arch',) }}

        {%- endif %}
    {%- endif %}
