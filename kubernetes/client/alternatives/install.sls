# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
    {%- set sls_archive_install = tplroot ~ '.client.archive.install' %}
    {%- set sls_binary_install = tplroot ~ '.client.binary.install' %}

include:
  - {{ sls_archive_install if d.client.pkg.use_upstream == 'archive' else sls_binary_install }}

    {%-  for cmd in d.client.pkg.commands|unique %}

{{ formula }}-client-alternatives-install-bin-{{ cmd }}:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - update-alternatives --get-selections |grep "^link-k8s-server-{{ cmd }}"    # avoid server clash
    - unless: {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-client-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - path: {{ d.client.pkg.path }}/bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_archive_install if d.client.pkg.use_upstream == 'archive' else sls_binary_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-client-{{ cmd }} {{ d.client.pkg.path }}/bin/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
    - unless:
      - update-alternatives --get-selections |grep "^link-k8s-server-{{ cmd }}"    # avoid server clash
    - require:
      - sls: {{ sls_archive_install if d.client.pkg.use_upstream == 'archive' else sls_binary_install }}

{{ formula }}-client-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - update-alternatives --get-selections |grep "^link-k8s-server-{{ cmd }}"    # avoid server clash
    - name: link-k8s-client-{{ cmd }}
    - path: {{ d.client.pkg.path }}/bin/{{ cmd }}
    - require:
      - alternatives: {{ formula }}-client-alternatives-install-bin-{{ cmd }}

    {%- endfor %}
{%- endif %}
