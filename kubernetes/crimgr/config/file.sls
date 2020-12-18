# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if grains.kernel|lower == 'linux' and 'config' in d.crimgr and d.crimgr.config %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
        {%- set sls_archive_install = tplroot ~ '.crimgr.archive.install' %}

include:
  - {{ sls_archive_install }}

kubernetes-crimgr-config-file-install-file-managed:
  file.managed:
    - name: {{ d.crimgr.config_file }}
    - source: {{ files_switch(['config.yml.jinja'],
                              lookup='k8s-crimgr-config-file-install-file-managed'
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
      config: {{ d.crimgr.config|json }}
    - require:
      - sls: {{ sls_archive_install }}

    {%- endif %}
