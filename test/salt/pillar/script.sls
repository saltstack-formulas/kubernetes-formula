# -*- coding: utf-8 -*-
# vim: ft=yaml
---
# This formula works with no-pillars but here are some example configurations.

kubernetes:
  supported:
    - client
    - k3s
  operator:
    wanted:
      - sdk
# test script installation
  k3s:
    pkg:
      use_upstream: script

  linux:
    altpriority: 1000
