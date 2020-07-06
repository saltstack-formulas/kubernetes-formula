# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.os_family|lower in ('redhat', 'debian') %}
        {%- if d.kubelet.pkg.use_upstream_repo %}
            {%- set sls_repo_clean = tplroot ~ '.package.repo.clean' %}
include:
  - {{ sls_repo_clean }}
        {%- endif %}

{{ formula }}-kubelet-package-clean-pkg:
  pkg.removed:
    - name: {{ d.kubelet.pkg.name }}
    - reload_modules: true
        {%- if d.kubelet.pkg.use_upstream_repo %}
    - require:
      - pkgrepo: {{ formula }}-package-repo-absent
        {%- endif %}

    {%- else %}

{{ formula }}-kubelet-package-clean-other:
  test.show_notification:
    - text: |
        The kubelet package is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
