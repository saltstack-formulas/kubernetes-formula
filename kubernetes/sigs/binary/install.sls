# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.os != 'Windows' %}

{{ formula }}-sigs-binary-deps-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}

    {%- endif %}
    {%- if 'wanted' in d.sigs and d.sigs.wanted %}
        {%- for tool in d.sigs.wanted|unique %}
            {%- if 'pkg' in d.sigs and tool in d.sigs['pkg'] and d.sigs['pkg'][tool] %}
                {%- if d.sigs.pkg[tool]['use_upstream'] == 'binary' and 'binary' in d.sigs.pkg[tool] %}
                    {%- set p = d.sigs['pkg'][tool] %}

{{ formula }}-sigs-binary-{{ tool }}-install:
  file.managed:
    - name: {{ p['path'] }}{{ tool }}
    - source: {{ p['binary']['source'] }}
                   {%- if 'source_hash' in p['binary'] and p['binary']['source_hash'] %}
    - source_hash: {{ p['binary']['source_hash'] }}
                   {%- else %}
    - skip_verify: True
                   {%- endif %}
    - makedirs: True
    - retry: {{ d.retry_option|json }}
                   {%- if grains.os != 'Windows' %}
    - mode: '0755'
    - require:
      - pkg: {{ formula }}-sigs-binary-deps-install
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
                   {%- elif tool in ('kind',) %}
  cmd.run:
    - name: mv {{d.dir.base~d.div~'bin'~d.div}}{{ tool }} {{d.dir.base~d.div~'bin'~d.div}}{{ tool }}.exe
    - onlyif: test -f {{d.dir.base~d.div~'bin'~d.div}}{{ tool }}

                   {%- endif %}
                   {%- if (d.linux.altpriority|int == 0 and grains.os != 'Windows') or grains.os_family in ('Arch', 'MacOS') %}
                       {%- for cmd in p['commands']|unique %}

{{ formula }}-sigs-binary-{{ tool }}-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ p['path'] }}/bin/{{ tool }}
    - force: True
    - onlyif:
      - test -f {{ p['path'] }}/bin/{{ tool }}
    - require:
      - file: {{ formula }}-sigs-binary-{{ tool }}-install

                       {%- endfor %}
                   {%- endif %}

                {%- endif %}
            {%- endif %}
        {%- endfor %}
    {%- endif %}
