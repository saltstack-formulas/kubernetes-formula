# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if 'wanted' in d.devtools and d.devtools.wanted %}
        {%- for tool in d.devtools.wanted|unique %}
            {%- if d.devtools.pkg[tool]['use_upstream'] == 'binary' %}
                {%- set p = d.devtools['pkg'] %}
                {%- if 'binary' in p[tool] and 'source' in p[tool]['binary'] %}

kubernetes-devtools-binary-{{ tool }}-install:
  file.managed:
    - name: {{ p[tool]['path'] }}{{ tool }}
    - source: {{ p[tool]['binary']['source'] }}
                    {%- if 'source_hash' in p[tool]['binary'] and p[tool]['binary']['source_hash'] %}
    - source_hash: {{ p[tool]['binary']['source_hash'] }}
                    {%- else %}
    - skip_verify: True
                    {%- endif %}
    - makedirs: True
    - force: True
    - retry: {{ d.retry_option|json }}
                    {%- if grains.os|lower == 'windows' %}
                        {%- if tool in ('devspace', 'k3s', 'kind', 'linkerd2', 'minikube', 'skaffold', 'stern') %}
  cmd.run:
    - name: mv {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }} {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }}.exe
    - onlyif: test -f {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }}
    - unless: cmp {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }} {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }}.exe
                        {%- endif %}

                    {%- else %}
    - mode: '0755'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}

                        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                            {%- for cmd in p[tool]['commands']|unique %}

kubernetes-devtools-binary-{{ tool }}-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ p[tool]['path'] }}{{ tool }}/bin/{{ cmd }}
    - force: True
    - onlyif:
      - test -f {{ p[tool]['path'] }}{{ tool }}/bin/{{ cmd }}
    - require:
      - file: kubernetes-devtools-binary-{{ tool }}-install
                            {%- endfor %}
                        {%- endif %}
                    {%- endif %}
                {%- endif %}
            {%- endif %}
        {%- endfor %}
        {%- if grains.os|lower == 'windows' %}

kubernetes-devtools-binary-install-bashrc:
  file.replace:
    - name: C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - pattern: '^export PATH=${PATH}:/cygdrive/c/kubernetes/bin$'
    - repl: 'export PATH=${PATH}:/cygdrive/c/kubernetes/bin'
    - append_if_not_found: True
  cmd.run:
    - name: sed -i -e "s/\r//g" C:\cygwin64\home\{{ d.identity.rootuser }}\.bashrc
    - onchanges:
      - file: kubernetes-devtools-binary-install-bashrc

        {%- endif %}
    {%- endif %}
