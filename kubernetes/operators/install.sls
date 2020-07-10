# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.operators and d.operators.wanted %}
        {%- for operator in d.operators.wanted %}
            {%- if 'pkg' in d.operators and d.operators['pkg'] and operator in d.operators['pkg'] %}

{{ formula }}-operator-install-{{ operator }}:
  file.directory:
    - name: {{ d.dir.source }}/{{ operator }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - clean: True
    - makedirs: True
    - require_in:
      - archive: {{ formula }}-operator-install-{{ operator }}
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    - name: {{ d.dir.source }}/{{ operator }}
    - source: {{ d.operators['pkg'][operator]['source'] }}
    - source_hash: {{ d.operators['pkg'][operator]['source_hash'] }}
    - retry: {{ d.retry_option }}
    - enforce_toplevel: false
    - options: '--strip-components=1'
    - trim_output: true
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group

            {% endif %}
        {% endfor %}
    {% endif %}
