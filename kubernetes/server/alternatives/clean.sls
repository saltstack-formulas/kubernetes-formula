# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
    {%- for cmd in d.server.pkg.commands|unique %}

{{ formula }}-server-alternatives-clean-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-server-{{ cmd }}
    - path: {{ d.server.pkg.path }}/bin/{{ cmd }}
    - onlyif: update-alternatives --get-selections |grep ^link-k8s-server-{{ cmd }}

    {%- endfor %}
{%- endif %}
