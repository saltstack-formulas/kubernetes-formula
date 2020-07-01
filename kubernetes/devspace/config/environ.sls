# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_install = tplroot ~ '.devspace.binary.install' %}

    {%- if 'environ' in k8s.devspace and k8s.devspace.environ %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  {{ '- ' + sls_package_install if k8s.devspace.pkg.use_upstream_repo else '' }}

k8s-devspace-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ k8s.devspace.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='k8s-devspace-config-file-file-managed-environ_file'
                 )
              }}
    - mode: '0640'
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        environ: {{ k8s.devspace.environ|json }}
    - require:
      {{ '- sls: ' + sls_binary_install if k8s.devspace.pkg.use_upstream_binary else '' }}

    {%- endif %}
