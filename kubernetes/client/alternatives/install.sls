# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- set sls_archive_install = tplroot ~ '.client.archive.install' %}
        {%- set sls_binary_install = tplroot ~ '.client.binary.install' %}

include:
  - {{ sls_archive_install }}
  - {{ sls_binary_install }}

        {%- for cmd in d.client.pkg.commands|unique %}

{{ formula }}-client-alternatives-install-bin-{{ cmd }}:
            {%- if grains.os_family not in ('Suse', 'Arch') %}
  alternatives.install:
    - name: link-k8s-client-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.client['pkg']['path'] }}/bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
            {%- else %}
  cmd.run:
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-client-{{ cmd }} {{ d.client['pkg']['path'] }}/bin/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
            {%- endif %}

    - onlyif:
      - test -f {{ d.client['pkg']['path'] }}/bin/{{ cmd }}
    - unless:
      - update-alternatives --list |grep ^link-k8s-client-{{ cmd }} || false
      - update-alternatives --list |grep "^link-k8s-server-{{ cmd }}" || false    # avoid server clash
    - require:
      - sls: {{ sls_archive_install if d.client.pkg.use_upstream == 'archive' else sls_binary_install }}
    - require_in:
      - alternatives: {{ formula }}-client-alternatives-set-bin-{{ cmd }}

{{ formula }}-client-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }} || false
      - update-alternatives --list |grep "^link-k8s-server-{{ cmd }}" || false    # avoid server clash
    - name: link-k8s-client-{{ cmd }}
    - path: {{ d.client.pkg.path }}/bin/{{ cmd }}
    - onlyif:
      - test -f {{ d.client['pkg']['path'] }}/bin/{{ cmd }}

        {%- endfor %}
    {%- endif %}
