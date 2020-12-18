# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if d.k3s.pkg.use_upstream == 'script' %}

    {%- if grains.os_family not in ('RedHat', 'Windows') %}
kubernetes-k3s-script-install-prerequisites:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
          {%- if grains.os_family in ('CentOS',) and d.k3s.pkg.deps_url %}
  cmd.run:
    - names:
              {%- for pkg in d.pkg.deps_url %}
      - yum install -y {{ pkg }}
              {%- endfor %}
    - require_in:
      - file: kubernetes-k3s-script-install-prerequisites
          {%- endif %}
  file.directory:
    - name: {{ d.dir.tmp }}
    - makedirs: True
    - require:
      - pkg: kubernetes-k3s-script-install-prerequisites
              {%- if grains.os != 'Windows' %}
    - mode: '0755'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
              {%- endif %}

kubernetes-k3s-script-download:
  file.managed:
    - name: {{ d.dir.tmp }}/k3s-bootstrap.sh
    - source: {{ d.k3s.pkg.script.source }}
    - source_hash: {{ d.k3s.pkg.script.source_hash }}
    - require:
      - file: kubernetes-k3s-script-install-prerequisites
              {%- if grains.os != 'Windows' %}
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
              {%- endif %}

kubernetes-k3s-script-download-clean:
  file.absent:
    - name: {{ d.dir.tmp }}/k3s-bootstrap.sh
    - onfail:
      - file: kubernetes-k3s-script-download

kubernetes-k3s-script-install:
  cmd.run:
    - name: {{ d.dir.tmp }}/k3s-bootstrap.sh
          {%- if 'env' in d.k3s.pkg.script and d.k3s.pkg.script.env %}
    - env:
              {%- for k,v in d.k3s.pkg.script.env.items() %}
      - {{ k }}: {{ v }}
              {%- endfor %}
          {%- endif %}
    - require:
      - file: kubernetes-k3s-script-download

    {%- else %}

kubernetes-k3s-package-install-other:
  test.show_notification:
    - text: |
        The k3s package is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}
        RedHat is bugged

    {%- endif %}
{%- endif %}
