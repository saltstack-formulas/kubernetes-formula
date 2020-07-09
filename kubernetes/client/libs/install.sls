# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.client.libs and d.client.libs.wanted %}
        {%- for lib in d.client.libs.wanted %}
            {%- if 'libs' in d.client and lib in d.client.libs and d.client.libs[lib] %}

{{ formula }}-client-libs-install-{{ lib }}:
  file.directory:
    - name: {{ d.dir.source }}/{{ lib }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - clean: True
    - makedirs: True
    - require_in:
      - archive: {{ formula }}-client-libs-install-{{ lib }}
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    - name: {{ d.dir.source }}/{{ lib }}
    - source: {{ d.client.libs[lib]['source'] }}
    - source_hash: {{ d.client.libs[lib]['source_hash'] }}
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
