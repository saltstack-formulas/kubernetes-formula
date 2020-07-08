# -*- coding: utf-8 -*-
# vim: ft=sls

kubernetes-kind-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/kind
      - /usr/local/kubernetes-kind-*
