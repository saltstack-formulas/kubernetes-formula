# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if grains.kernel|lower in ('linux', 'darwin', 'windows') %}
    {%- if 'wanted' in d.operator.sdk and d.operator.sdk.wanted %}
        {%- for item in d.operator.sdk.wanted|unique %}
            {%- if d.operator.sdk.pkg[item]['use_upstream'] == 'binary' %}
                {%- set p = d.operator.sdk['pkg'] %}
                {%- if item in p and 'binary' in p[item] and 'source' in p[item]['binary'] %}

{{ formula }}-operator-sdk-binary-{{ item }}-install:
  file.managed:
    - name: {{ p[item]['path'] }}{{ item }}
    - source: {{ p[item]['binary']['source'] }}
    - retry: {{ d.retry_option|json }}
    - mode: 755
    - skip_verify: True
    - makedirs: True
    - force: True
                    {%- if grains.os != 'Windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
      - user
      - group
      - mode
                    {%- endif %}

{{ formula }}-operator-sdk-binary-{{ item }}-verify:
  file.managed:
    - name: {{ p[item]['path'] }}/{{ item }}.asc
    - source: {{ p[item]['binary']['source_hash'] }}
    - retry: {{ d.retry_option|json }}
    - skip_verify: True
    - makedirs: True
    - force: True
                    {%- if grains.os != 'Windows' %}
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
      - user
      - group
      - mode
                    {%- endif %}
  cmd.run:
    - names:
      - gpg --keyserver {{ d.operator.sdk['rsakeyserver'] }} --recv-key {{ d.operator.sdk['rsakey'] }}
      - gpg --verify {{ p[item]['path'] }}{{ item }}.asc
      - rm {{ p[item]['path'] }}{{ item }}.asc
    - require:
      - file: {{ formula }}-operator-sdk-binary-{{ item }}-install
      - file: {{ formula }}-operator-sdk-binary-{{ item }}-verify

{{ formula }}-operator-sdk-binary-{{ item }}-failure:
  file.absent:
    - names:
      - {{ p[item]['path'] }}{{ item }}
      - {{ p[item]['path'] }}{{ item }}.asc
    - onfail:
      - cmd: {{ formula }}-operator-sdk-binary-{{ item }}-verify

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}

{%- endif %}
