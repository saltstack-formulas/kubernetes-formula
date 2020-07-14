# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - .client
  - .server
  - .node
  - .k3s
  - .operators
  - .devtools
  - .devlibs
  - .sigs

{{ formula }}-pkg-deps-install:
  pkg.installed:
    - name: tar
