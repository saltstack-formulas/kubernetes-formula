# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- set sls_archive_install = tplroot ~ '.server.archive.install' %}
        {%- set sls_package_install = tplroot ~ '.server.package.install' %}

include:
  - {{ sls_archive_install }}
  - {{ sls_package_install }}

        {%- for cmd in d.server.pkg.commands|unique %}
kubernetes-server-alternatives-install-bin-{{ cmd }}:
            {%- if grains.os_family not in ('Suse', 'Arch') %}
  alternatives.install:
    - name: link-k8s-server-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.server['pkg']['path'] }}/bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
            {%- else %}
  cmd.run:
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-server-{{ cmd }} {{ d.server['pkg']['path'] }}/bin/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
            {%- endif %}

    - onlyif:
      - test -f {{ d.server['pkg']['path'] }}/bin/{{ cmd }}
    - unless:
      - update-alternatives --list |grep ^link-k8s-server-{{ cmd }} || false
      - update-alternatives --list |grep "^link-k8s-client-{{ cmd }}" || false  # avoid client clash
      - update-alternatives --list |grep "^link-k8s-node-{{ cmd }}" || false    # avoid node clash
    - require:
      - sls: {{ sls_archive_install if d.client.pkg.use_upstream == 'archive' else sls_binary_install }}
    - require_in:
      - alternatives: kubernetes-server-alternatives-set-bin-{{ cmd }}

kubernetes-server-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }} || false
      - update-alternatives --list |grep "^link-k8s-client-{{ cmd }}" || false  # avoid client clash
      - update-alternatives --list |grep "^link-k8s-node-{{ cmd }}" || false    # avoid node clash
    - name: link-k8s-server-{{ cmd }}
    - path: {{ d.server.pkg.path }}/bin/{{ cmd }}
    - onlyif:
      - test -f {{ d.server['pkg']['path'] }}/bin/{{ cmd }}

        {%- endfor %}
    {%- endif %}
