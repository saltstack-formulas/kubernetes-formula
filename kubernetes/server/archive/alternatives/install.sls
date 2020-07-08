# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

        {%- if d.server.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}

include:
  - {{ sls_archive_install }}

            {%- for cmd in d.server.pkg.commands %}

{{ formula }}-server-archive-alternatives-install-{{ cmd }}:
  alternatives.install:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-server-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - path: {{ d.server.pkg.archive.name }}/bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_archive_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-server {{ d.server.pkg.archive.name }}/bin/{{ cmd }} {{ d.linux.altpriority }} # noqa 204

{{ formula }}-server-archive-alternatives-set-{{ cmd }}:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-server-{{ cmd }}
    - path: {{ d.server.pkg.archive.name }}/bin/{{ cmd }}
    - require:
      - alternatives: {{ formula }}-server-archive-alternatives-install-{{ cmd }}
      - sls: {{ sls_archive_install }}

            {%- endfor %}
        {%- endif %}
    {%- endif %}
