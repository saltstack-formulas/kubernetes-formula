# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.devtools and d.devtools.wanted %}
        {%- for tool in d.devtools.wanted|unique %}
            {%- if tool in d.devtools['pkg'] and 'binary' in d.devtools['pkg'][tool] %}

{{ formula }}-devtools-{{ tool }}-binary-install:
  file.directory:
    - name: {{ d.devtools['pkg'][tool]['binary']['name'] }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-devtools-{{ tool }}-binary-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ d.devtools['pkg'][tool]['binary']['name'] }}/bin/{{ tool }} {{ d.devtools['pkg'][tool]['binary']['source'] }}  # noqa 204
      - chmod '0755' {{ d.devtools['pkg'][tool]['binary']['name'] }}/bin/{{ tool }} 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
      {%- if 'source_hash' in d.devtools['pkg'][tool]['binary'] and d.devtools['pkg'][tool]['binary']['source_hash'] %}  # noqa 204
  module.run:
    - name: file.check_hash
    - path: {{ d.devtools['pkg'][tool]['binary']['name'] }}/bin/{{ tool }}
    - file_hash: {{ d.devtools['pkg'][tool]['binary']['source_hash'] }}
    - require:
      - cmd: {{ formula }}-devtools-{{ tool }}-binary-install
      {%- endif %}

                {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                    {%- for cmd in d.devtools['pkg'][tool]['commands']|unique %}

{{ formula }}-devtools-{{ tool }}-binary-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.devtools['pkg'][tool]['binary']['name'] }}/{{ tool }}
    - force: True
    - require:
      - cmd: {{ formula }}-devtools-{{ tool }}-binary-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}

                    {% endfor %}
                {% endif %}

            {% endif %}
        {%- endfor %}
    {%- endif %}
