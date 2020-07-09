# -*- coding: utf-8 -*-
# vim: ft=yaml
---
kubernetes:
  supported:
    - server
    - client
    - node
    - devspace
    - istio
    - linkerd2
    - kubebuilder
    - octant
    - k3s
    - kind
    - kudo
    - minikube
    - operators

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
