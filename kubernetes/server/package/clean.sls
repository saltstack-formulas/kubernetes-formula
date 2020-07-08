# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.os_family|lower in ('redhat', 'debian') %}
        {%- if d.server.pkg.use_upstream_repo %}
            {%- set sls_repo_clean = tplroot ~ '.package.repo.clean' %}
include:
  - {{ sls_repo_clean }}
        {%- endif %}

{{ formula }}-server-package-clean-pkgs:
  pkg.removed:
    - names: {{ d.server.pkg.commands|json }}
    - reload_modules: true
        {%- if d.server.pkg.use_upstream_repo %}
    - require:
      - pkgrepo: {{ formula }}-package-repo-absent
        {%- endif %}

    {%- else %}

{{ formula }}-server-package-clean-other:
  test.show_notification:
    - text: |
        The server package is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
