# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-k3s-script-install-prerequisites:
  pkg.installed:
    - names: {{ d.k3s.pkg.deps|json }}
      {%- if grains.os_family in ('CentOS',) and d.k3s.pkg.deps_url %}
  cmd.run:
    - names:
          {%- for pkg in d.k3s.pkg.deps_url %}
      - yum install -y {{ pkg }}
          {%- endfor %}
    - require_in:
      - file: {{ formula }}-k3s-script-install-prerequisites
      {%- endif %}
  file.directory:
    - names:
      - {{ d.dir.tmp }}
    - user: root
    - group: {{ d.identity.rootgroup }}
    - mode: '0755'
    - makedirs: True
    - require:
      - pkg: {{ formula }}-k3s-script-install-prerequisites

{{ formula }}-k3s-script-download:
  file.managed:
    - name: {{ d.dir.tmp }}/k3s-bootstrap.sh
    - source: {{ d.k3s.pkg.script.source }}
    - source_hash: {{ d.k3s.pkg.script.source_hash }}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: 755
    - require:
      - file: {{ formula }}-k3s-script-install-prerequisites

{{ formula }}-k3s-script-download-clean:
  file.absent:
    - name: {{ d.dir.tmp }}/k3s-bootstrap.sh
    - onfail:
      - file: {{ formula }}-k3s-script-download

{{ formula }}-k3s-script-install:
  cmd.run:
    - name: {{ d.dir.tmp }}/k3s-bootstrap.sh
      {%- if 'env' in d.k3s.pkg.script and d.k3s.pkg.script.env %}
    - env:
          {%- for k,v in d.k3s.pkg.script.env.items() %}
      - {{ k }}: {{ v }}
          {%- endfor %}
      {%- endif %}
    - require:
      - file: {{ formula }}-k3s-script-download
