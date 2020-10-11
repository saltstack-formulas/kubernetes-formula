# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if 'config' in d.server and d.server.config %}
    {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
    {%- set sls_archive_install = tplroot ~ '.server.archive.install' %}
    {%- set sls_package_install = tplroot ~ '.server.package.install' %}

include:
  - {{ sls_archive_install if d.server.pkg.use_upstream == 'archive' else sls_package_install }}

{{ formula }}-server-config-file-install-file-managed:
  file.managed:
    - name: {{ d.server.config_file }}
    - source: {{ files_switch(['config.yml.jinja'],
                              lookup='k8s-server-config-file-install-file-managed'
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
      config: {{ d.server.config|json }}
    - require:
      - sls: {{ sls_archive_install if d.server.pkg.use_upstream == 'archive' else sls_package_install }}

{%- endif %}
