# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

        {%- if d.devtools.kubectx.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}

include:
  - {{ sls_archive_clean }}

            {%- for cmd in d.devtools.kubectx.pkg.commands %}

{{ formula }}-devtools-kubectx-archive-alternatives-remove-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-kubectx-{{ cmd }}
    - path: {{ d.devtools.kubectx.pkg.archive.name }}/{{ cmd }}
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-kubectx-{{ cmd }}
    - require:
      - sls: {{ sls_archive_clean }}

            {%- endfor %}
        {%- endif %}
    {%- endif %}
