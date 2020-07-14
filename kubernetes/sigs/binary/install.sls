# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-sigs-binary-deps-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}

{%- if 'wanted' in d.sigs and d.sigs.wanted %}
    {%- for tool in d.sigs.wanted|unique %}
        {%- if 'pkg' in d.sigs and tool in d.sigs['pkg'] and d.sigs['pkg'][tool] %}
            {%- if d.sigs.pkg[tool]['use_upstream'] == 'binary' and 'binary' in d.sigs.pkg[tool] %}
                {%- set p = d.sigs['pkg'][tool] %}

{{ formula }}-sigs-binary-{{ tool }}-install:
  file.directory:
    - name: {{ p['path'] }}/bin
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - makedirs: True
    - require:
      - pkg: {{ formula }}-sigs-binary-deps-install
    - require_in:
      - cmd: {{ formula }}-sigs-binary-{{ tool }}-install
    - recurse:
        - user
        - group
        - mode
  cmd.run:
    - names:
      - curl -Lo {{ p['path'] }}/bin/{{ tool }} {{ p['binary']['source'] }}
      - chmod '0755' {{ p['path'] }}/bin/{{ tool }} 2>/dev/null
    - retry: {{ d.retry_option|json }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
                {%- if 'source_hash' in p['binary'] and p['binary']['source_hash'] %}
  module.run:
    - name: file.check_hash
    - path: {{ p['path'] }}/bin/{{ tool }}
    - file_hash: {{ p['binary']['source_hash'] }}
    - require:
      - cmd: {{ formula }}-sigs-binary-{{ tool }}-install
                {%- endif %}

                {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                    {%- for cmd in p['commands']|unique %}

{{ formula }}-sigs-binary-{{ tool }}-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ p['path'] }}/bin/{{ tool }}
    - force: True
    - onlyif: test -f {{ p['path'] }}/bin/{{ tool }}
    - require:
      - binary: {{ formula }}-sigs-binary-{{ tool }}-install

                    {%- endfor %}
                {%- endif %}

            {%- endif %}
        {%- endif %}
    {%- endfor %}
{%- endif %}
