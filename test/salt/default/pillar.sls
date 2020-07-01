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
      use_upstream_repo: false
      use_upstream_binary: true
  minikube:
    environ:
      a: b
    linux:
      altpriority: 1000
    pkg:
      use_upstream_binary: true
