# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- if 'wanted' in d.crimgr and d.crimgr.wanted and d.crimgr['pkg'] %}
            {%- for cmd in d.crimgr['pkg']['commands']|unique %}

kubernetes-cri-resource-manager-alternatives-clean-{{ cmd }}:
  alternatives.remove:
    - name: link-k8s-cri-resource-manager-{{ cmd }}
    - path: {{ d.crimgr.pkg['path'] }}/bin/{{ cmd }}
    - onlyif:
      - update-alternatives --list |grep ^link-k8s-cri-resource-manager-{{ cmd }}

            {%- endfor %}
        {%- endif %}
    {%- endif %}
