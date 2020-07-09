# -*- coding: utf-8 -*-
# vim: ft=sls

{%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

    {%- set tplroot = tpldir.split('/')[0] %}
    {%- from tplroot ~ "/map.jinja" import data as d with context %}
    {%- set formula = d.formula %}
    {%- set sls_archive_install = tplroot ~ '.devtools.install' %}

include:
  - {{ sls_archive_install }}

    {%- if 'wanted' in d.devtools and d.devtools.wanted %}
        {%- for tool in d.devtools.wanted %}
            {%- if tool in d.devtools and d.devtools[tool] %}
                {%- if d.devtools[tool]['pkg']['use_upstream_archive'] and d.linux.altpriority|int > 0 %}
                    {%- for cmd in d.devtools[tool]['pkg']['commands'] %}

{{ formula }}-devtools-{{ tool }}-archive-alternatives-install-{{ cmd }}:
  alternatives.install:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-devtools-{{ tool }}-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - path: {{ d.devtools[tool]['pkg']['archive']['path'] }}/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_archive_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-devtools-{{ tool }}-{{ cmd }} {{ d.devtools[tool]['pkg']['archive']['path'] }}/{{ cmd }} {{ d.linux.altpriority }} # noqa 204

{{ formula }}-devtools-{{ tool }}-archive-alternatives-set-{{ cmd }}:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-devtools-{{ tool }}-{{ cmd }}
    - path: {{ d.devtools[tool]['pkg']['archive']['path'] }}/{{ cmd }}
    - require:
      - alternatives: {{ formula }}-devtools-{{ tool }}-archive-alternatives-install-{{ cmd }}
      - sls: {{ sls_archive_install }}

                    {%- endfor %}
                {%- endif %}
            {%- endif %}

        {%- endfor %}
    {%- endif %}
{%- endif %}
