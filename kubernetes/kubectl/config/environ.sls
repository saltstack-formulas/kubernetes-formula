# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'environ' in d.kubectl and d.kubectl.environ %}
        {%- set sls_binary_install = tplroot ~ '.kubectl.binary.install' %}
        {%- set sls_package_install = tplroot ~ '.kubectl.package.install' %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_binary_install if d.kubectl.pkg.use_upstream_binary else sls_package_install }}

{{ formula }}-kubectl-config-file-managed-environ_file:
  file.managed:
    - name: {{ d.kubectl.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='k8s-kubectl-config-file-managed-environ_file'
                 )
              }}
    - mode: '0640'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        environ: {{ d.kubectl.environ|json }}
    - require:
      - sls: {{ sls_binary_install if d.kubectl.pkg.use_upstream_binary else sls_package_install }}

    {%- endif %}
