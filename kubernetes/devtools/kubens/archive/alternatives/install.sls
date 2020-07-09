# -*- coding: utf-8 -*-
# vim: ft=sls

    {%- if grains.kernel|lower == 'linux' and grains.os_family not in ('Arch',) %}

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

        {%- if d.devtools.kubens.pkg.use_upstream_archive and d.linux.altpriority|int > 0 %}

include:
  - {{ sls_archive_install }}

            {%- for cmd in d.devtools.kubens.pkg.commands %}

{{ formula }}-devtools-kubens-archive-alternatives-install-{{ cmd }}:
  alternatives.install:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-kubens-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - path: {{ d.devtools.kubens.pkg.archive.name }}/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
    - order: 10
    - require:
      - sls: {{ sls_archive_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-kubens {{ d.devtools.kubens.pkg.archive.name }}/{{ cmd }} {{ d.linux.altpriority }} # noqa 204

{{ formula }}-devtools-kubens-archive-alternatives-set-{{ cmd }}:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-kubens-{{ cmd }}
    - path: {{ d.devtools.kubens.pkg.archive.name }}/{{ cmd }}
    - require:
      - alternatives: {{ formula }}-devtools-kubens-archive-alternatives-install-{{ cmd }}
      - sls: {{ sls_archive_install }}

            {%- endfor %}
        {%- endif %}
    {%- endif %}
