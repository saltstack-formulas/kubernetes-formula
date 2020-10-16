# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- set sls_script_install = tplroot ~ '.k3s.script.install' %}
        {%- set sls_binary_install = tplroot ~ '.k3s.binary.install' %}

include:
  - {{ sls_script_install }}
  - {{ sls_binary_install }}

        {%- for cmd in d.k3s['pkg']['commands']|unique %}

{{ formula }}-k3s-alternatives-install-bin-{{ cmd }}:
            {%- if grains.os_family in ('Suse', 'Arch') %}
  alternatives.install:
    - name: link-k8s-k3s-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.k3s['pkg']['path'] }}/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
            {%- else %}
  cmd.run:
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-k8s-k3s-{{ cmd }} {{ d.k3s['pkg']['path'] }}/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
            {%- endif %}

    - onlyif:
      - test -f {{ d.k3s['pkg']['path'] }}/{{ cmd }}
    - unless: update-alternatives --list |grep ^link-k8s-k3s-{{ cmd }} || false
    - require:
      - sls: {{ sls_script_install if d.k3s.pkg['use_upstream'] == 'script' else sls_binary_install }}
    - require_in:
      - alternatives: {{ formula }}-k3s-alternatives-set-bin-{{ cmd }}

{{ formula }}-k3s-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }} || false
    - name: link-k8s-k3s-{{ cmd }}
    - path: {{ d.k3s['pkg']['path'] }}/{{ cmd }}
    - onlyif: test -f {{ d.k3s['pkg']['path'] }}/{{ cmd }}

        {%- endfor %}
    {%- endif %}
