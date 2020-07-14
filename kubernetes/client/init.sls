# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{%- set sls_archive_install = tplroot ~ '.client.archive.install' %}
{%- set sls_package_install = tplroot ~ '.client.package.install' %}
{%- set sls_binary_install = tplroot ~ '.client.binary.install' %}

include:
  - {{ sls_archive_install if d.client.pkg.use_upstream == 'archive' else sls_binary_install if d.client.pkg.use_upstream == 'binary' else sls_package_install }}  # noqa 204
  - .aliases
  - .alternatives
