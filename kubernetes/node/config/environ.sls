# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if 'environ' in d.node and d.node.environ %}
    {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
    {%- set sls_archive_install = tplroot ~ '.node.archive.install' %}
    {%- set sls_package_install = tplroot ~ '.node.package.install' %}

include:
  - {{ sls_archive_install if d.node.pkg.use_upstream == 'archive' else sls_package_install }}

kubernetes-node-config-file-managed-environ_file:
  file.managed:
    - name: {{ d.node.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='k8s-node-config-file-managed-environ_file'
                 )
              }}
    - makedirs: True
    - template: jinja
              {%- if grains.os != 'Windows' %}
    - mode: '0640'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
              {%- endif %}
    - context:
      environ: {{ d.node.environ|json }}
    - require:
      - sls: {{ sls_archive_install if d.node.pkg.use_upstream == 'archive' else sls_package_install }}

    {%- endif %}
