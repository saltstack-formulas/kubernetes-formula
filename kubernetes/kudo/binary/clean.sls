# -*- coding: utf-8 -*-
# vim: ft=sls

kubernetes-kudo-binary-clean:
  file.absent:
    - names:
      - /usr/local/bin/kubectl-kudo
      - /usr/local/bin/kudo
