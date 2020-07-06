# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'environ' in d.minikube and d.minikube.environ %}
        {%- set sls_binary_install = tplroot ~ '.minikube.binary.install' %}
        {%- set sls_package_install = tplroot ~ '.minikube.package.install' %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_binary_install if d.minikube.pkg.use_upstream_binary else sls_package_install }}

{{ formula }}-minikube-config-file-managed-environ_file:
  file.managed:
    - name: {{ d.minikube.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='k8s-minikube-config-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        environ: {{ d.minikube.environ|json }}
    - require:
      - sls: {{ sls_binary_install if d.minikube.pkg.use_upstream_binary else sls_package_install }}

    {%- endif %}
