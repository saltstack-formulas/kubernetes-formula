# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- set sls_archive_install = tplroot ~ '.node.archive.install' %}
        {%- set sls_binary_install = tplroot ~ '.node.binary.install' %}

include:
  - {{ sls_archive_install if d.node.pkg.use_upstream == 'archive' else sls_binary_install }}

        {%- for cmd in d.node.pkg.commands|unique %}
{{ formula }}-node-alternatives-install-bin-{{ cmd }}:
            {%- if grain.os_family not in ('Suse', 'Arch')
  alternatives.install:
    - name: link-k8s-node-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.node['pkg']['path'] }}/bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
            {%- else %}
  cmd.run:
    - name: update-alternatives --install /usr/local/{{ cmd }} link-k8s-node-{{ cmd }} {{ d.node['pkg']['path'] }}/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
            {%- endif %}

    - onlyif: test -f {{ d.node['pkg']['path'] }}/{{ cmd }}
    - unless:
      - update-alternatives --get-selections |grep ^link-k8s-node-{{ cmd }}
      - update-alternatives --get-selections |grep "^link-k8s-server-{{ cmd }}"    # avoid server clash
      - update-alternatives --get-selections |grep "^link-k8s-client-{{ cmd }}"    # avoid client clash
    - require:
      - sls: {{ sls_archive_install }}
      - sls: {{ sls_binary_install }}
    - require_in:
      - alternatives: {{ formula }}-node-alternatives-set-bin-{{ cmd }}

{{ formula }}-node-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - update-alternatives --get-selections |grep "^link-k8s-server-{{ cmd }}"    # avoid server clash
      - update-alternatives --get-selections |grep "^link-k8s-client-{{ cmd }}"    # avoid client clash
    - name: link-k8s-node-{{ cmd }}
    - path: {{ d.node.pkg.path }}/bin/{{ cmd }}
    - onlyif: test -f {{ d.node['pkg']['path'] }}/{{ cmd }}

        {%- endfor %}
    {%- endif %}
