# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
    {%- set sls_archive_install = tplroot ~ '.server.archive.install' %}

include:
  - {{ sls_archive_install }}

    {%- for cmd in d.server.pkg.commands|unique %}

{{ formula }}-server-alternatives-install-{{ cmd }}:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - update-alternatives --get-selections |grep "^link-k8s-client-{{ cmd }}"   # avoid client clash
    - name: link-k8s-server-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - path: {{ d.server.pkg.path }}/bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_archive_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-server-{{ cmd }} {{ d.server.pkg.path }}/bin/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
    - unless:
      - update-alternatives --get-selections |grep "^link-k8s-client-{{ cmd }}"   # avoid client clash
    - require:
      - sls: {{ sls_archive_install }}

{{ formula }}-server-alternatives-set-{{ cmd }}:
  alternatives.set:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - update-alternatives --get-selections |grep '^link-k8s-client-{{ cmd }}'   # avoid client clash
    - name: link-k8s-server-{{ cmd }}
    - path: {{ d.server.pkg.path }}/bin/{{ cmd }}
    - require:
      - alternatives: {{ formula }}-server-alternatives-install-{{ cmd }}

    {%- endfor %}
{%- endif %}
