# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- for cmd in d.k3s['pkg']['commands']|unique %}

kubernetes-k3s-alternatives-clean-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-k3s-{{ cmd }}
    - path: {{ d.k3s['pkg']['path'] }}/{{ cmd }}
    - onlyif:
      - update-alternatives --list |grep ^link-k8s-k3s-{{ cmd }}

        {%- endfor %}
    {%- endif %}
