# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

        {%- if d.node.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}

include:
  - {{ sls_archive_clean }}

            {%- for cmd in d.node.pkg.commands %}

{{ formula }}-node-archive-alternatives-remove-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-node-{{ cmd }}
    - path: {{ d.node.pkg.archive.name }}/bin/{{ cmd }}
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-node-{{ cmd }}
    - require:
      - sls: {{ sls_archive_clean }}

            {%- endfor %}
        {%- endif %}
    {%- endif %}
