# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- set sls_archive_install = tplroot ~ '.crimgr.archive.install' %}

include:
  - {{ sls_archive_install }}

        {%- if 'wanted' in d.crimgr and d.crimgr.wanted and 'pkg' in d.crimgr and d.crimgr['pkg'] %}
            {%- for cmd in d.crimgr['pkg']['commands']|unique %}

kubernetes-cri-resource-manager-alternatives-install-bin-{{ cmd }}:
                {%- if grains.os_family in ('Suse', 'Arch') %}
  alternatives.install:
    - name: link-k8s-cri-resource-manager-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.crimgr.pkg['path'] }}/bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
                {%- else %}
  cmd.run:
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-cri-resource-manager-{{ cmd }} {{ d.crimgr.pkg['path'] }}/bin/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
                {%- endif %}

    - onlyif:
      - test -f {{ d.crimgr.pkg['path'] }}/bin/{{ cmd }}
    - unless: update-alternatives --list |grep ^link-k8s-cri-resource-manager-{{ cmd }} || false
    - require:
      - sls: {{ sls_archive_install }}
    - require_in:
      - alternatives: kubernetes-cri-resource-manager-alternatives-set-bin-{{ cmd }}

kubernetes-cri-resource-manager-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }} || false
    - name: link-k8s-cri-resource-manager-{{ cmd }}
    - path: {{ d.crimgr.pkg['path'] }}/bin/{{ cmd }}
    - onlyif:
      - test -f {{ d.crimgr.pkg['path'] }}/bin/{{ cmd }}

            {%- endfor %}
        {%- endif %}
    {%- endif %}
