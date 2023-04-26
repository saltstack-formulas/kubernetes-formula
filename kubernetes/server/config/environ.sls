# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if 'environ' in d.server and d.server.environ %}
    {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
    {%- set sls_archive_install = tplroot ~ '.server.archive.install' %}
    {%- set sls_package_install = tplroot ~ '.server.package.install' %}

include:
  - {{ sls_archive_install if d.server.pkg.use_upstream == 'archive' else sls_package_install }}

kubernetes-server-config-file-managed-environ_file:
  file.managed:
    - name: {{ d.server.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='kubernetes-server-config-file-managed-environ_file'
                 )
              }}
    - makedirs: True
              {%- if grains.os != 'Windows' %}
    - mode: '0640'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
              {%- endif %}
    - template: jinja
    - context:
      environ: {{ d.server.environ|json }}
    - require:
      - sls: {{ sls_archive_install if d.server.pkg.use_upstream == 'archive' else sls_package_install }}

{%- endif %}
