# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.k3s.pkg.use_upstream == 'script' %}
        {%- if grains.os_family not in ('Redhat',) %}

kubernetes-k3s-script-clean-killall:
  cmd.run:
    - name: {{ d.k3s.pkg.script.killall }}
    - onlyif:
      - test -f {{ d.k3s.pkg.script.killall }}

kubernetes-k3s-script-clean-uninstall:
  cmd.run:
    - names:
      - sleep 15
      - {{ d.k3s.pkg.script.uninstall }}
    - onlyif:
      - test -f {{ d.k3s.pkg.script.uninstall }}

kubernetes-k3s-script-clean-file-absent:
  file.absent:
    - names:
      - {{ d.dir.tmp }}
      - {{ d.k3s.pkg.script.killall }}
      - {{ d.k3s.pkg.script.uninstall }}
    - require:
      - cmd: kubernetes-k3s-script-clean-killall
      - cmd: kubernetes-k3s-script-clean-uninstall

        {%- else %}

kubernetes-k3s-package-uninstall-other:
  test.show_notification:
    - text: |
        The k3s package is unavailable for {{ salt['grains.get']('finger', grains.os_family) }}
        RedHat is bugged

        {%- endif %}
    {%- endif %}
