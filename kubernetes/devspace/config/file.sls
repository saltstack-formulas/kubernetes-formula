# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_install = tplroot ~ '.devspace.binary.install' %}

    {%- if 'config' in k8s.devspace and k8s.devspace.config %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  {{ '- ' + sls_binary_install if k8s.devspace.pkg.use_upstream_binary else '' }}

k8s-devspace-config-file-install-file-managed:
  file.managed:
    - name: {{ k8s.devspace.config_file }}
    - source: {{ files_switch(['config.yml.jinja'],
                              lookup='k8s-devspace-config-file-install-file-managed'
                 )
              }}
    - mode: 644
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        config: {{ k8s.devspace.config|json }}
    - require:
      {{ '- sls: ' + sls_binary_install if k8s.devspace.pkg.use_upstream_binary else '' }}

    {%- endif %}
