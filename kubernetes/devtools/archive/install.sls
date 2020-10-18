#  -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {%- if 'wanted' in d.devtools and d.devtools.wanted %}

        {%- if grains.os != 'Windows' %}
{{ formula }}-devtools-pkg-deps-install:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
        {%- endif %}

        {%- for tool in d.devtools.wanted|unique %}
            {%- if 'pkg' in d.devtools and tool in d.devtools['pkg'] and d.devtools['pkg'][tool] %}
                {%- set p = d.devtools.pkg[tool] %}
                {%- if p['use_upstream'] == 'archive' and 'archive' in p %}

{{ formula }}-devtools-archive-{{ tool }}-install:
  file.directory:
    - name: {{ d.devtools['pkg'][tool]['path'] }}
    - clean: {{ d.clean }}
    - makedirs: True
    - require_in:
      - archive: {{ formula }}-devtools-archive-{{ tool }}-install
                     {%- if grains.os != 'Windows' %}
    - require:
      - pkg: {{ formula }}-devtools-pkg-deps-install
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
                     {%- endif %}
  archive.extracted:
    {{- format_kwargs(d.devtools['pkg'][tool]['archive']) }}
    - retry: {{ d.retry_option }}
    - enforce_toplevel: false
    - trim_output: true
                     {%- if grains.os != 'Windows' %}
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
                     {%- elif tool in ('devspace', 'k3s', 'kind', 'linkerd2', 'minikube', 'skaffold', 'stern') %}
  cmd.run:
    - name: mv {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }} {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }}.exe
    - onlyif: test -f {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}{{ tool }}

                     {%- endif %}
                     {%- if (d.linux.altpriority|int == 0 and grains.os != 'Windows') or grains.os_family in ('Arch', 'MacOS') %}
                         {%- for cmd in d.devtools['pkg'][tool]['commands']|unique %}

{{ formula }}-devtools-archive-{{ tool }}-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.devtools['pkg'][tool]['path'] }}/bin/{{ tool }}
    - force: True
    - onlyif:
      - test -f {{ d.devtools['pkg'][tool]['path'] }}/bin/{{ tool }}
    - require:
      - archive: {{ formula }}-devtools-archive-{{ tool }}-install

                         {% endfor %}
                     {% endif %}
               {% endif %}
            {% endif %}
        {%- endfor %}
        {%- if grains.os == 'Windows' %}{# tidyup c:\kubernetes\bin #}

{{ formula }}-devtools-archive-install-windows-tidyup:
  cmd.run:
    - names:
      - mv {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}istio-{{ d.devtools.pkg.istio.version }}{{ d.div ~ 'bin' ~ d.div }}istioctl {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}  # noqa 204
      - mv {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}octant_{{ d.devtools.pkg.octant.version }}_Windows-64Bit{{ d.div }}octant {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}  # noqa 204
  file.absent:
    - names:
       - {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}/doc
       - {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}/README.md
       - {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}/LICENSE
       - {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}istio-{{ d.devtools.pkg.istio.version }}
       - {{ d.dir.base ~ d.div ~ 'bin' ~ d.div }}octant_{{ d.devtools.pkg.octant.version }}_Windows-64Bit

        {%- endif %}
    {%- endif %}
