# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
    {%- set sls_archive_install = tplroot ~ '.sigs.archive.install' %}
    {%- set sls_binary_install = tplroot ~ '.sigs.binary.install' %}
include:
  - {{ sls_archive_install }}
  - {{ sls_binary_install }}

    {%- if 'wanted' in d.sigs and d.sigs.wanted %}
        {%- for tool in d.sigs.wanted|unique %}
            {%- if tool not in ('kubebuilder', 'krew') and tool in d.sigs.pkg and d.sigs.pkg[tool] %}
                {%- for cmd in d.sigs.pkg[tool]['commands']|unique %}

{{ formula }}-sigs-{{ tool }}-alternatives-install-bin-{{ cmd }}:
  alternatives.install:
    - unless:
      - {{ grains.os_family in ('Suse', 'Arch') }}
      - update-alternatives --get-selections |grep ^link-k8s-sigs-{{ tool }}-{{ cmd }}
    - name: link-k8s-sigs-{{ tool }}-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.sigs.pkg[tool]['path'] }}/bin/{{ cmd }}
    - onlyif: test -f {{ d.sigs.pkg[tool]['path'] }}bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
    - require:
      - {{ sls_archive_install if d.sigs.pkg[tool]['use_upstream'] == 'archive' else sls_binary_install }}
  cmd.run:
    - onlyif: {{ grains.os_family in ('Suse',) }}
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-sigs-{{ tool }}-{{ cmd }} {{ d.sigs.pkg[tool]['path'] }}/bin/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
    - unless:
      - update-alternatives --get-selections |grep ^link-k8s-sigs-{{ tool }}-{{ cmd }}
    - require:
       - sls: {{ sls_archive_install }}
       - sls: {{ sls_binary_install }}

{{ formula }}-sigs-{{ tool }}-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }}
    - name: link-k8s-sigs-{{ tool }}-{{ cmd }}
    - path: {{ d.sigs.pkg[tool]['path'] }}/bin/{{ cmd }}
    - onlyif: test -f {{ d.sigs.pkg[tool]['path'] }}/{{ cmd }}
    - require:
       - sls: {{ sls_archive_install }}
       - sls: {{ sls_binary_install }}

                {%- endfor %}
            {%- endif %}

        {%- endfor %}
    {%- endif %}
{%- endif %}
