# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_clean = tplroot ~ '.kubectl.binary.clean' %}
{%- set sls_package_clean = tplroot ~ '.kubectl.package.clean' %}
{%- set sls_source_clean = tplroot ~ '.kubectl.source.clean' %}

    {%- if 'environ' in k8s.kubectl and k8s.kubectl.environ %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_binary_clean }}
  - {{ sls_package_clean }}
  - {{ sls_source_clean }}

k8s-kubectl-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ k8s.kubectl.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='k8s-kubectl-config-file-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: {{ k8s.rootuser }}
    - group: {{ k8s.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        environ: {{ k8s.kubectl.environ|json }}
    - require:
      - sls: {{ sls_binary_clean }}
      - sls: {{ sls_package_clean }}
      - sls: {{ sls_source_clean }}

    {%- endif %}
