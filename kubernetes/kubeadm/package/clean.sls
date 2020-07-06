# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower in ('linux',) %}
        {%- if d.kubeadm.pkg.use_upstream_repo %}
            {%- set sls_repo_clean = tplroot ~ '.package.repo.clean' %}
include:
  - {{ sls_repo_clean }}
        {%- endif %}

{{ formula }}-kubeadm-package-clean-pkg:
  pkg.removed:
    - name: {{ d.kubeadm.pkg.name }}
    - reload_modules: true
        {%- if d.kubeadm.pkg.use_upstream_repo %}
    - require:
      - pkgrepo: {{ formula }}-package-repo-absent
        {%- endif %}

    {%- else %}

{{ formula }}-kubeadm-package-clean-other:
  test.show_notification:
    - text: |
        The kubeadm package is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
