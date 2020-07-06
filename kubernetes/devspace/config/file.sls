# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'config' in d.devspace and d.devspace.config %}
        {%- set sls_binary_install = tplroot ~ '.devspace.binary.install' %}
        {%- set sls_package_install = tplroot ~ '.devspace.package.install' %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_binary_install if d.devspace.pkg.use_upstream_binary else sls_package_install }}

{{ formula }}-devspace-config-file-install-file-managed:
  file.managed:
    - name: {{ d.devspace.config_file }}
    - source: {{ files_switch(['config.yml.jinja'],
                              lookup='k8s-devspace-config-file-install-file-managed'
                 )
              }}
    - mode: 644
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        config: {{ d.devspace.config|json }}
    - require:
      - sls: {{ sls_binary_install if d.devspace.pkg.use_upstream_binary else sls_package_install }}

    {%- endif %}
