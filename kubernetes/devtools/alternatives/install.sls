# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- set sls_archive_install = tplroot ~ '.devtools.archive.install' %}
        {%- set sls_binary_install = tplroot ~ '.devtools.binary.install' %}

include:
  - {{ sls_archive_install }}
  - {{ sls_binary_install }}

        {%- if 'wanted' in d.devtools and d.devtools.wanted %}
            {%- for tool in d.devtools.wanted|unique %}
                {%- if 'pkg' in d.devtools and tool in d.devtools['pkg'] and d.devtools['pkg'][tool] %}
                    {%- for cmd in d.devtools['pkg'][tool]['commands']|unique %}

{{ formula }}-devtools-{{ tool }}-alternatives-install-bin-{{ cmd }}:
                        {%- if grains.os_family in ('Suse', 'Arch') %}
  alternatives.install:
    - name: link-k8s-devtools-{{ tool }}-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.devtools['pkg'][tool]['path'] }}/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
                        {%- else %}
  cmd.run:
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-devtools-{{ tool }}-{{ cmd }} {{ d.devtools['pkg'][tool]['path'] }}/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
                        {%- endif %}

    - onlyif:
      - test -f {{ d.devtools['pkg'][tool]['path'] }}/{{ cmd }}
    - unless: update-alternatives --list |grep ^link-k8s-devtools-{{ tool }}-{{ cmd }} || false
    - require:
      - sls: {{ sls_archive_install if d.devtools.pkg[tool]['use_upstream'] == 'archive' else sls_binary_install }}
    - require_in:
      - alternatives: {{ formula }}-devtools-{{ tool }}-alternatives-set-bin-{{ cmd }}

{{ formula }}-devtools-{{ tool }}-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }} || false
    - name: link-k8s-devtools-{{ tool }}-{{ cmd }}
    - path: {{ d.devtools['pkg'][tool]['path'] }}/{{ cmd }}
    - onlyif:
      - test -f {{ d.devtools['pkg'][tool]['path'] }}/{{ cmd }}

                    {%- endfor %}
                {%- endif %}
            {%- endfor %}
        {%- endif %}
    {%- endif %}
