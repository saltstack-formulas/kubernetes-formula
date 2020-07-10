# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'wanted' in d.devtools and d.devtools.wanted %}
        {%- for tool in d.devtools.wanted %}
            {%- if 'pkg' in d.devtools and tool in d.devtools['pkg'] and d.devtools['pkg'][tool] %}
                {%- if 'archive' in d.devtools['pkg'][tool] %}

{{ formula }}-devtools-{{ tool }}-archive-install:
  file.directory:
    - name: {{ d.devtools[tool]['pkg']['archive']['name'] }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: {{ formula }}-devtools-{{ tool }}-archive-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ d.devtools[tool]['pkg']['archive']['name'] }}/bin/[tool] {{ d[tool]['pkg']['archive']['source'] }}
      - chmod '0755' {{ d.devtools[tool]['pkg']['archive']['name'] }}/bin/[tool] 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
      {%- if 'source_hash' in d.devtools[tool]['pkg']['archive'] and d[tool]['pkg']['archive']['source_hash'] %}
  module.run:
    - name: file.check_hash
    - path: {{ d.devtools[tool]['pkg']['archive']['name'] }}/bin/{{ tool }}
    - file_hash: {{ d.devtools[tool]['pkg']['archive']['source_hash'] }}
    - require:
      - cmd: {{ formula }}-devtools-{{ tool }}-archive-install
      {%- endif %}

                    {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                        {%- for cmd in d.devtools['pkg'][tool]['commands'] %}

{{ formula }}-devtools-{{ tool }}-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.devtools['pkg'][tool]['archive']['name'] }}/{{ tool }}
    - force: True
    - require:
      - cmd: {{ formula }}-devtools-{{ tool }}-archive-install
    - unless:
      - {{ d.linux.altpriority|int > 0 }}
      - {{ grains.os_family|lower in ('windows',) }}

                        {% endfor %}
                    {% endif %}
                {% endif %}

            {% endif %}
        {%- endfor %}
    {%- endif %}
