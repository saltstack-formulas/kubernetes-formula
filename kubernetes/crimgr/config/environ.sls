# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if grains.kernel|lower == 'linux' and 'environ' in d.crimgr and d.crimgr.environ %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
        {%- set sls_archive_install = tplroot ~ '.crimgr.archive.install' %}

include:
  - {{ sls_archive_install }}

kubernetes-crimgr-config-file-managed-environ_file:
  file.managed:
    - name: {{ d.crimgr.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='k8s-crimgr-config-file-managed-environ_file'
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
      environ: {{ d.crimgr.environ|json }}
    - require:
      - sls: {{ sls_archive_install }}

    {%- endif %}
