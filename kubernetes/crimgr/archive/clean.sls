# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if grains.kernel|lower == 'linux' %}
        {%- if 'pkg' in d.crimgr and d.crimgr.pkg %}

kubernetes-cri-resource-manager-archive-clean:
  file.absent:
    - names:
      # warning: don't list 'd.crimgr.pkg['path']' here (/)
      - /usr/local/etc/cri-resmgr
      - /usr/local/etc/default/cri-resource-manager
      - /usr/local/etc/systemd/system/cri-resource-manager.service
      - /usr/local/etc/default/cri-resource-manager
      - /usr/local/opt/intel/bin/cri-resmgr
      - /usr/local/opt/intel/share/doc/cri-resource-manager/
      - /usr/local/opt/intel/share/doc/cri-resource-manager/security.md
      - /usr/local/opt/intel/share/doc/cri-resource-manager/LICENSE

        {% endif %}
    {%- else %}

kubernetes-cri-resource-manager-archive-clean-other:
  test.show_notification:
    - text: |
        The cri-resource-manager archive is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
