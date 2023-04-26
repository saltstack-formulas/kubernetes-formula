# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if grains.os != 'Windows' %}
    {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
    {%- set sls_archive_install = tplroot ~ '.client.archive.install' %}
    {%- set sls_binary_install = tplroot ~ '.client.binary.install' %}
    {%- set sls_package_install = tplroot ~ '.client.package.install' %}

include:
  - {{ sls_archive_install if d.client.pkg.use_upstream == 'archive' else sls_binary_install if d.client.pkg.use_upstream == 'binary' else sls_package_install }}   # noqa 204

kubernetes-client-aliases-file-managed-environ_file:
  file.managed:
    - name: {{ d.client.aliases_file }}
    - source: {{ files_switch(['aliases.sh.jinja'],
                              lookup='kubernetes-client-aliases-file-managed-environ_file'
                 )
              }}
    - makedirs: True
                 {%- if grains.os != 'Windows' %}
    - mode: '0640'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
                 {%- endif %}
    - template: jinja
    - require:
      - sls: {{ sls_archive_install if d.client.pkg.use_upstream == 'archive' else sls_binary_install if d.client.pkg.use_upstream == 'binary' else sls_package_install }}   # noqa 204

{%- endif %}
