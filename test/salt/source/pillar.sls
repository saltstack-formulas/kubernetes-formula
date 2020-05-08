# -*- coding: utf-8 -*-
# vim: ft=yaml
---
kubernetes:
  kubectl:
    environ:
      a: b
    linux:
      altpriority: 1000
    pkg:
      deps:
        - tar
      use_upstream_source: true
      use_upstream_repo: false
      use_upstream_binary: false
  minikube:
    environ:
      a: b
    linux:
      altpriority: 1000
    pkg:
      deps:
        - tar
