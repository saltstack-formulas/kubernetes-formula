# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.node.pkg.use_upstream in ('package', 'repo') %}
        {%- if grains.os_family|lower in ('redhat', 'debian') %}
            {%- if d.node.pkg.use_upstream == 'repo' %}
                {%- set sls_repo_clean = tplroot ~ '.package.repo.clean' %}
include:
  - {{ sls_repo_clean }}
            {%- endif %}

kubernetes-node-package-clean-pkgs:
  pkg.removed:
    - names: {{ d.node.pkg.commands|unique|json }}
    - reload_modules: true
            {%- if d.node.pkg.use_upstream == 'repo' %}
    - require:
      - pkgrepo: kubernetes-package-repo-absent
            {%- endif %}

        {%- endif %}
    {%- endif %}
