# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if 'wanted' in d.devtools and d.devtools.wanted %}
    {%- for tool in d.devtools.wanted|unique %}
        {%- if d.devtools.pkg[tool]['use_upstream'] == 'binary' %}
            {%- set p = d.devtools['pkg'] %}
            {%- if tool in p and 'binary' in p[tool] and 'source' in p[tool]['binary'] %}

{{ formula }}-devtools-binary-{{ tool }}-install:
  file.directory:
    - name: {{ p[tool]['path'] }}/bin
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-devtools-binary-{{ tool }}-install
                {%- if grains.os != 'Windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
                {%- endif %}
  cmd.run:
    - names:
      - curl -Lo {{ p[tool]['path'] }}/bin/{{ tool }} {{ p[tool]['binary']['source'] }}
      - chmod '0755' {{ p[tool]['path'] }}/bin/{{ tool }} 2>/dev/null
    - retry: {{ d.retry_option|json }}
                {%- if grains.os != 'Windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
                {%- endif %}
                {%- if 'source_hash' in p[tool]['binary'] and p[tool]['binary']['source_hash'] %}
  module.run:
    - name: file.check_hash
    - path: {{ p[tool]['path'] }}/bin/{{ tool }}
    - file_hash: {{ p[tool]['binary']['source_hash'] }}
    - require:
      - cmd: {{ formula }}-devtools-binary-{{ tool }}-install
                {%- endif %}

                {%- if (d.linux.altpriority|int == 0 and grain.os != 'Windows') or grains.os_family in ('Arch', 'MacOS') %}
                    {%- for cmd in p[tool]['commands']|unique %}
{{ formula }}-devtools-binary-{{ tool }}-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ p[tool]['path'] }}/bin/{{ tool }}
    - force: True
    - onlyif: test -f {{ p[tool]['path'] }}/bin/{{ tool }}
    - require:
      - cmd: {{ formula }}-devtools-binary-{{ tool }}-install
                    {% endfor %}
                {% endif %}

            {% endif %}
        {% endif %}
    {%- endfor %}
{%- endif %}
