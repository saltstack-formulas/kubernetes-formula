# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}
        {%- if d.istio.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}

include:
  - {{ sls_archive_install }}

{{ formula }}-istio-archive-alternatives-install:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-istio
    - link: /usr/local/bin/istio
    - path: {{ d.istio.pkg.archive.name }}/bin/istio
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_archive_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/istio link-k8s-istio {{ d.istio.pkg.archive.name }}/bin/istio {{ d.linux.altpriority }} # noqa 204

{{ formula }}-istio-archive-alternatives-set:
  alternatives.set:
    - unless:
      # {{ grains.os in ('Debian',) }}
      - {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-istio
    - path: {{ d.istio.pkg.archive.name }}/bin/istio
    - require:
      - alternatives: {{ formula }}-istio-archive-alternatives-install
      - sls: {{ sls_archive_install }}

        {%- endif %}
    {%- endif %}
