# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if 'config' in d.k3s and d.k3s.config %}
    {%- set sls_archive_install = tplroot ~ '.k3s.archive.install' %}
    {%- set sls_binary_install = tplroot ~ '.k3s.binary.install' %}
    {%- set sls_package_install = tplroot ~ '.k3s.package.install' %}
    {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_archive_install if d.k3s.pkg.use_upstream == 'archive' else sls_binary_install if d.k3s.pkg.use_upstream == 'binary' else sls_package_install }}   # noqa 204

{{ formula }}-k3s-config-file-install-file-managed:
  file.managed:
    - name: {{ d.k3s.config_file }}
    - source: {{ files_switch(['config.yml.jinja'],
                              lookup='k8s-k3s-config-file-install-file-managed'
                 )
              }}
    - mode: 644
    - makedirs: True
                {%- if grains.os != 'Windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
                {%- endif %}
    - template: jinja
    - context:
      config: {{ d.k3s.config|json }}
    - require:
      - sls: {{ sls_archive_install if d.k3s.pkg.use_upstream == 'archive' else sls_binary_install if d.k3s.pkg.use_upstream == 'binary' else sls_package_install }}   # noqa 204

{%- endif %}
