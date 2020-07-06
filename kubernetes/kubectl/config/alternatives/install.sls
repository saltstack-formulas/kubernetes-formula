# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

        {%- if not d.kubectl.pkg.use_upstream_repo and d.linux.altpriority|int > 0 %}
            {%- set sls_binary_install = tplroot ~ '.kubectl.binary.install' %}
            {%- set sls_package_install = tplroot ~ '.kubectl.package.install' %}

include:
  - {{ sls_binary_install if d.kubectl.pkg.use_upstream_binary else sls_package_install }}

{{ formula }}-kubectl-config-alternatives-install:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ d.kubectl.pkg.use_upstream_repo }}
    - name: link-k8s-kubectl
    - link: /usr/local/bin/kubectl
    - path: {{ d.kubectl.pkg.binary.name }}/bin/kubectl
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_binary_install if d.kubectl.pkg.use_upstream_binary else sls_package_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/kubectl link-k8s-kubectl {{ d.kubectl.pkg.binary.name }}/bin/kubectl {{ d.linux.altpriority }} # noqa 204

{{ formula }}-kubectl-config-alternatives-set:
  alternatives.set:
    - unless:
      # {{ grains.os in ('Debian',) }}
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ d.kubectl.pkg.use_upstream_repo }}
    - name: link-k8s-kubectl
    - path: {{ d.kubectl.pkg.binary.name }}/bin/kubectl
    - require:
      - alternatives: {{ formula }}-kubectl-config-alternatives-install
      - sls: {{ sls_binary_install if d.kubectl.pkg.use_upstream_binary else sls_package_install }}

        {%- endif %}
    {%- endif %}
