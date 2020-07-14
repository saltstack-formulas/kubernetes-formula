# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
    {%- set sls_archive_install = tplroot ~ '.node.archive.install' %}
include:
  - {{ sls_archive_install }}

    {%- for cmd in d.node.pkg.commands|unique %}

{{ formula }}-node-alternatives-install-bin-{{ cmd }}:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - update-alternatives --get-selections |egrep "^link-k8s-server-{{ cmd }}|link-k8s-client-{{ cmd }}"
    - name: link-k8s-node-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - path: {{ d.node.pkg.path }}/bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_archive_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-node-{{ cmd }} {{ d.node.pkg.path }}/bin/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
    - unless:
      - update-alternatives --get-selections |egrep "^link-k8s-server-{{ cmd }}|link-k8s-client-{{ cmd }}"
    - require:
      - sls: {{ sls_archive_install }}

{{ formula }}-node-alternatives-set-{{ cmd }}:
  alternatives.set:
    - unless:
      - update-alternatives --get-selections |egrep "^link-k8s-server-{{ cmd }}|link-k8s-client-{{ cmd }}"
      - {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-node-{{ cmd }}
    - path: {{ d.node.pkg.path }}/bin/{{ cmd }}
    - require:
      - alternatives: {{ formula }}-node-alternatives-install-bin-{{ cmd }}

    {%- endfor %}
{%- endif %}
