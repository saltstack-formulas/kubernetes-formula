# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- if d.k3s.pkg.use_upstream == 'script' %}
    {%- if grains.os_family not in ('Redhat',) %}

{{ formula }}-k3s-script-clean-killall:
  cmd.run:
    - name: {{ d.k3s.pkg.script.killall }}
    - onlyif: test -f {{ d.k3s.pkg.script.killall }}

{{ formula }}-k3s-script-clean-uninstall:
  cmd.run:
    - names:
      - sleep 15
      - {{ d.k3s.pkg.script.uninstall }}
    - onlyif: test -f {{ d.k3s.pkg.script.uninstall }}

{{ formula }}-k3s-script-clean-file-absent:
  file.absent:
    - names:
      - {{ d.dir.tmp }}
      - {{ d.k3s.pkg.script.killall }}
      - {{ d.k3s.pkg.script.uninstall }}
    - require:
      - cmd: {{ formula }}-k3s-script-clean-killall
      - cmd: {{ formula }}-k3s-script-clean-uninstall

    {%- else %}

{{ formula }}-k3s-package-uninstall-other:
  test.show_notification:
    - text: |
        The k3s package is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}
        RedHat is bugged

    {%- endif %}
{%- endif %}
