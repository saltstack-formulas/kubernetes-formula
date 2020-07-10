# Changelog

## [1.6.1](https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.6.0...v1.6.1) (2020-07-10)


### Documentation

* **readme:** expanded documentation ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/8cae5c7))

# [1.6.0](https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.5.0...v1.6.0) (2020-07-10)


### Bug Fixes

* **macos:** resolve [#31](https://github.com/saltstack-formulas/kubernetes-formula/issues/31) ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/ecd83ac))
* **syntax:** get travis ci passing ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/85969de))


### Code Refactoring

* **devtools:** consoldiate states ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/4ae1c36))
* **tools:** rename to devtools ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/acab20b))


### Continuous Integration

* **redhat:** standalone centos/fedora tests ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/ac0d984))


### Documentation

* **readme:** fix readme ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/0ba0b77))


### Features

* **devtools:** add kubectx, kubens ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/b81b6ac))
* **istio:** support istio archive ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/6565ac2))
* **linkerd:** add linkerd2 support ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/80858a4))
* **octant:** add vmware-tanzur/octant support ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/dd55b72))
* **operators:** support for kubernetes operators ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/d3f30c7))

# [1.5.0](https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.4.1...v1.5.0) (2020-07-09)


### Features

* **clientlibs:** kubernetes api client libs ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/983227e))
* **kind:** add kind support ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/b4cdb90))

## [1.4.1](https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.4.0...v1.4.1) (2020-07-08)


### Code Refactoring

* **kubernetes:** add server, client, node states ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/49eb3b2))


### Continuous Integration

* **alternatives:** test for kubebuilder linux alternatives ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/c8431fd))
* **tests:** fix failures ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/8a787d8))

# [1.4.0](https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.3.0...v1.4.0) (2020-07-07)


### Features

* **utils:** kubebuilder support ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/6995116))

# [1.3.0](https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.2.1...v1.3.0) (2020-07-07)


### Bug Fixes

* **state:** package repo fix ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/ee37c64))


### Features

* **kubecli:** add kubeadm/kubelet support ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/c0159c3))

## [1.2.1](https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.2.0...v1.2.1) (2020-07-06)


### Bug Fixes

* **macos:** add fullpath to brew ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/8edae91))
* **macos:** fix group ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/936ae46))

# [1.2.0](https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.1.0...v1.2.0) (2020-07-06)


### Features

* **kudo:** add kubectl-kudo support ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/73c1930))

# [1.1.0](https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.0.0...v1.1.0) (2020-07-06)


### Code Refactoring

* **formula:** simplify; add devspace, k3s; expand tests ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/fea0ce2))


### Features

* **devspace:** add devspace support ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/e7629b7))

# 1.0.0 (2020-07-01)


### Bug Fixes

* **issues:** second commit ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/71f170e))
* **jinja:** corrected jinja variables and logic ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/19b3136))
* **jinja:** rename conflicting stuff ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/9fadf37))


### Code Refactoring

* **config:** simplify & fix config states ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/71101dc))


### Continuous Integration

* **travis:** install conntracker; setup k8s env ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/4af876b))
* **travis:** update kitchen platforms ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/7903ef7))
* **travis:** update travis tests ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/5e356be))
* **travis:** update travis tests ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/583bdec))


### Features

* **formula:** first commit ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/c173a4a))
* **semantic-release:** standardise for this formula ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/9ed2025))
* **suse:** add suse os support ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/2c32d33))
* **suse:** corrected url for source code ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/26adc3f))


### Tests

* **kitchen:** add ci support; align to template-formula ([](https://github.com/saltstack-formulas/kubernetes-formula/commit/5cbeb37))


### BREAKING CHANGES

* **kitchen:** Major refactor of formula to bring it in alignment with the
template-formula. As with all substantial changes, please ensure your
existing configurations work in the ways you expect from this formula.

refactor(symlink): ensure symlink is managed good
