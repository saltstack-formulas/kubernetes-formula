# -*- coding: utf-8 -*-
# vim: ft=sls

  {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import kubernetes as k8s with context %}
{%- set sls_binary_install = tplroot ~ '.devspace.binary.install' %}

        {%- if not k8s.devspace.pkg.use_upstream_repo and k8s.devspace.linux.altpriority|int > 0 %}

include:
  {{ '- ' + sls_binary_install if k8s.devspace.pkg.use_upstream_binary else '' }}

k8s-devspace-config-alternatives-install-k8s-devspace-alternative-install:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ k8s.devspace.pkg.use_upstream_repo }}
    - name: link-k8s-devspace
    - link: /usr/local/bin/devspace
    - path: {{ k8s.devspace.pkg.binary.name }}/bin/devspace
    - priority: {{ k8s.devspace.linux.altpriority }}
    - order: 10
    - require:
      {{ '- sls: ' + sls_binary_install if k8s.devspace.pkg.use_upstream_binary else '' }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/devspace link-k8s-devspace {{ k8s.devspace.pkg.binary.name }}/bin/devspace {{ k8s.devspace.linux.altpriority }} # noqa 204

k8s-devspace-config-alternatives-install-k8s.devspace-alternative-set:
  alternatives.set:
    - unless:
      # {{ grains.os in ('Debian',) }}
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - {{ k8s.devspace.pkg.use_upstream_repo }}
    - name: link-k8s-devspace
    - path: {{ k8s.devspace.pkg.binary.name }}/bin/devspace
    - require:
      - alternatives: k8s-devspace-config-alternatives-install-k8s-devspace-alternative-install
      {{ '- sls: ' + sls_binary_install if k8s.devspace.pkg.use_upstream_binary else '' }}

        {%- endif %}
  {%- endif %}
