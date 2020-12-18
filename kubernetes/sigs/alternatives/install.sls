# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- set sls_archive_install = tplroot ~ '.sigs.archive.install' %}
        {%- set sls_binary_install = tplroot ~ '.sigs.binary.install' %}
include:
  - {{ sls_archive_install }}
  - {{ sls_binary_install }}

        {%- if 'wanted' in d.sigs and d.sigs.wanted %}
            {%- for tool in d.sigs.wanted|unique %}
                {%- if tool in d.sigs.pkg and d.sigs.pkg[tool] %}
                    {%- for cmd in d.sigs.pkg[tool]['commands']|unique %}


kubernetes-sigs-{{ tool }}-alternatives-install-bin-{{ cmd }}:
                    {%- if grains.os_family not in ('Suse', 'Arch') %}
  alternatives.install:
    - name: link-k8s-sigs-{{ tool }}-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.sigs['pkg'][tool]['path'] }}/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
                    {%- else %}
  cmd.run:
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-sigs-{{ tool }}-{{ cmd }} {{ d.sigs['pkg'][tool]['path'] }}/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
                    {%- endif %}

    - onlyif:
      - test -f {{ d.sigs['pkg'][tool]['path'] }}/{{ cmd }}
    - unless: update-alternatives --list |grep ^link-k8s-sigs-{{ tool }}-{{ cmd }} || false
    - require:
      - sls: {{ sls_archive_install if d.sigs.pkg[tool]['use_upstream'] == 'archive' else sls_binary_install }}
    - require_in:
      - alternatives: kubernetes-sigs-{{ tool }}-alternatives-set-bin-{{ cmd }}

kubernetes-sigs-{{ tool }}-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }} || false
    - name: link-k8s-sigs-{{ tool }}-{{ cmd }}
    - path: {{ d.sigs['pkg'][tool]['path'] }}/{{ cmd }}
    - onlyif:
      - test -f {{ d.sigs['pkg'][tool]['path'] }}/{{ cmd }}

                    {%- endfor %}
                {%- endif %}

            {%- endfor %}
        {%- endif %}
    {%- endif %}
