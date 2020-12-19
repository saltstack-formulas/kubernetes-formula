# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- for cmd in d.client.pkg.commands|unique %}

kubernetes-client-alternatives-remove-bin-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-client-{{ cmd }}
    - path: {{ d.client.pkg.path }}/bin/{{ cmd }}
    - onlyif:
      - update-alternatives --list |grep ^link-k8s-client-{{ cmd }}

        {%- endfor %}
    {%- endif %}
