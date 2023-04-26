# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if 'config' in d.node and d.node.config %}
    {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
    {%- set sls_archive_install = tplroot ~ '.node.archive.install' %}
    {%- set sls_package_install = tplroot ~ '.node.package.install' %}

include:
  - {{ sls_archive_install if d.node.pkg.use_upstream == 'archive' else sls_package_install }}

kubernetes-node-config-file-install-file-managed:
  file.managed:
    - name: {{ d.node.config_file }}
    - source: {{ files_switch(['config.yml.jinja'],
                              lookup='kubernetes-node-config-file-install-file-managed'
                 )
              }}
    - makedirs: True
              {%- if grains.os != 'Windows' %}
    - mode: 644
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
              {%- endif %}
    - template: jinja
    - context:
        config: {{ d.node.config|json }}
    - require:
      - sls: {{ sls_archive_install if d.node.pkg.use_upstream == 'archive' else sls_package_install }}

{%- endif %}
