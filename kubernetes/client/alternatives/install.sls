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

        {%- for cmd in d.client.pkg.commands|unique %}
{{ formula }}-client-alternatives-install-bin-{{ cmd }}:
            {%- if grain.os_family not in ('Suse', 'Arch')
  alternatives.install:
    - name: link-k8s-client-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.client['pkg']['path'] }}/bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
            {%- else %}
  cmd.run:
    - name: update-alternatives --install /usr/local/{{ cmd }} link-k8s-client-{{ cmd }} {{ d.client['pkg']['path'] }}/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
            {%- endif %}

    - onlyif: test -f {{ d.client['pkg']['path'] }}/{{ cmd }}
    - unless:
      - update-alternatives --get-selections |grep ^link-k8s-client-{{ cmd }}
      - update-alternatives --get-selections |grep "^link-k8s-server-{{ cmd }}"    # avoid server clash
    - require:
      - sls: {{ sls_archive_install }}
      - sls: {{ sls_binary_install }}
    - require_in:
      - alternatives: {{ formula }}-client-alternatives-set-bin-{{ cmd }}

{{ formula }}-client-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - update-alternatives --get-selections |grep "^link-k8s-server-{{ cmd }}"    # avoid server clash
    - name: link-k8s-client-{{ cmd }}
    - path: {{ d.client.pkg.path }}/bin/{{ cmd }}
    - onlyif: test -f {{ d.client['pkg']['path'] }}/{{ cmd }}

        {%- endfor %}
    {%- endif %}
