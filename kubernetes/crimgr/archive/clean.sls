# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if grains.kernel|lower == 'linux' %}
        {%- if 'pkg' in d.crimgr and d.crimgr.pkg %}

kubernetes-cri-resource-manager-archive-clean:
  file.absent:
    - names:
      - {{ d.crimgr.pkg['path'] }}
      - /etc/systemd/system/cri-resource-manager.service
      - /etc/cri-resmgr
      - /etc/default/cri-resource-manager
            {%- for cmd in d.crimgr['pkg']['commands']|unique %}
      - /usr/local/bin/{{ cmd }}
            {%- endfor %}

        {% endif %}
    {%- else %}

kubernetes-cri-resource-manager-archive-clean-other:
  test.show_notification:
    - text: |
        The cri-resource-manager archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
