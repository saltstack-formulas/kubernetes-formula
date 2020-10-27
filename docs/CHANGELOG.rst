
Changelog
=========

`1.3.0 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.2.0...v1.3.0>`_ (2020-10-27)
------------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **windows:** add path to bashrc (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/bfb9d87>`_\ )

`1.2.0 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.1.0...v1.2.0>`_ (2020-10-18)
------------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **windows:** kubernetes-client fixed (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/5160842>`_\ )
* **windows:** kubernetes.node fix (overwrite=true) (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/e9050dd>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** update os support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/10023a8>`_\ )

Features
^^^^^^^^


* **windows:** store binaries in c:\kubernetes\bin (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/bd94157>`_\ )

`1.1.0 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.0.0...v1.1.0>`_ (2020-10-18)
------------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **windows:** various corrections (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/89ac0bf>`_\ )
* **windows:** various corrections (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/60e6258>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **arch/suse:** get travis ci passing (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/415a8b7>`_\ )

Features
^^^^^^^^


* **windows:** windows support and various fixes (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/b282180>`_\ )

1.0.0 (2020-10-11)
------------------

Bug Fixes
^^^^^^^^^


* **arch:** ensure tar gets installed (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/d290a51>`_\ )
* **centos:** selinux-policy-minimum provides base (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/48973e0>`_\ )
* **issues:** second commit (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/71f170e>`_\ )
* **jinja:** corrected jinja variables and logic (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/19b3136>`_\ )
* **jinja:** fixup various things (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/c350d58>`_\ )
* **jinja:** need else condition (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/da3d005>`_\ )
* **jinja:** rename conflicting stuff (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/9fadf37>`_\ )
* **k3s:** update map.jinja for k3s.script state (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/460540e>`_\ )
* **linux:** corrected alternatives states (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/f96f727>`_\ )
* **macos:** add fullpath to brew (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/8edae91>`_\ )
* **macos:** fix group (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/936ae46>`_\ )
* **macos:** resolve `#31 <https://github.com/saltstack-formulas/kubernetes-formula/issues/31>`_ (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/ecd83ac>`_\ )
* **state:** package repo fix (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/ee37c64>`_\ )
* **state:** wrong requires - fixed (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/7cbab8f>`_\ )
* **syntax:** get travis ci passing (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/85969de>`_\ )
* **typo:** rename grain to grains (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/685cd3c>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **config:** simplify & fix config states (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/71101dc>`_\ )
* **devtools:** consoldiate states (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/4ae1c36>`_\ )
* **formula:** more simplified design (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/622e132>`_\ )
* **formula:** simplify; add devspace, k3s; expand tests (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/fea0ce2>`_\ )
* **kubernetes:** add server, client, node states (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/49eb3b2>`_\ )
* **tools:** rename to devtools (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/acab20b>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **alternatives:** test for kubebuilder linux alternatives (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/c8431fd>`_\ )
* **redhat:** enable linux alternatives (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/18403a8>`_\ )
* **redhat:** standalone centos/fedora tests (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/ac0d984>`_\ )
* **tests:** fix failures (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/8a787d8>`_\ )
* **travis:** install conntracker; setup k8s env (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/4af876b>`_\ )
* **travis:** update kitchen platforms (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/7903ef7>`_\ )
* **travis:** update travis tests (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/5e356be>`_\ )
* **travis:** update travis tests (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/583bdec>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** expand clientlibs section (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/dcee1f9>`_\ )
* **readme:** expanded documentation (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/8cae5c7>`_\ )
* **readme:** fix readme (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/0ba0b77>`_\ )
* **readme:** fix something (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/a8d7024>`_\ )

Features
^^^^^^^^


* **aliases:** basic kubectl-aliases support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/a4bd703>`_\ )
* **clientlibs:** kubernetes api client libs (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/983227e>`_\ )
* **develop:** krew & skaffold support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/1922196>`_\ )
* **devspace:** add devspace support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/e7629b7>`_\ )
* **devtools:** add kubectx, kubens (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/b81b6ac>`_\ )
* **docker:** dive tool support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/d28ced0>`_\ )
* **formula:** first commit (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/c173a4a>`_\ )
* **istio:** support istio archive (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/6565ac2>`_\ )
* **kind:** add kind support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/b4cdb90>`_\ )
* **kubecli:** add kubeadm/kubelet support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/c0159c3>`_\ )
* **kubectl:** shell completion support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/7ba5e77>`_\ )
* **kudo:** add kubectl-kudo support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/73c1930>`_\ )
* **linkerd:** add linkerd2 support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/80858a4>`_\ )
* **octant:** add vmware-tanzur/octant support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/dd55b72>`_\ )
* **operator-sdk:** add sdk operator support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/fdb2019>`_\ )
* **operators:** support for kubernetes operators (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/d3f30c7>`_\ )
* **semantic-release:** standardise for this formula (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/9ed2025>`_\ )
* **stern:** add stern container viewer (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/161acc1>`_\ )
* **suse:** add suse os support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/2c32d33>`_\ )
* **suse:** corrected url for source code (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/26adc3f>`_\ )
* **utils:** kubebuilder support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/6995116>`_\ )
* **win:** do not apply user/group to windows filesystem (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/4be7c26>`_\ )
* **windows:** basic kubectl package support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/3848610>`_\ )
* **windows:** kubernetes node support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/a197ef6>`_\ )

Tests
^^^^^


* **devtools:** more tests (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/a9b2fa7>`_\ )
* **kitchen:** add ci support; align to template-formula (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/5cbeb37>`_\ )

BREAKING CHANGES
^^^^^^^^^^^^^^^^


* **formula:** consolidation of states under few headings
* **kitchen:** Major refactor of formula to bring it in alignment with the
  template-formula. As with all substantial changes, please ensure your
  existing configurations work in the ways you expect from this formula.

refactor(symlink): ensure symlink is managed good

`2.0.1 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v2.0.0...v2.0.1>`_ (2020-07-14)
------------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **arch:** ensure tar gets installed (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/d290a51>`_\ )
* **centos:** selinux-policy-minimum provides base (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/48973e0>`_\ )
* **linux:** corrected alternatives states (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/f96f727>`_\ )
* **state:** wrong requires - fixed (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/7cbab8f>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **redhat:** enable linux alternatives (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/18403a8>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** expand clientlibs section (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/dcee1f9>`_\ )

`2.0.0 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.6.1...v2.0.0>`_ (2020-07-14)
------------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **jinja:** fixup various things (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/c350d58>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **formula:** more simplified design (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/622e132>`_\ )

Features
^^^^^^^^


* **aliases:** basic kubectl-aliases support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/a4bd703>`_\ )
* **develop:** krew & skaffold support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/1922196>`_\ )
* **docker:** dive tool support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/d28ced0>`_\ )
* **kubectl:** shell completion support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/7ba5e77>`_\ )
* **stern:** add stern container viewer (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/161acc1>`_\ )

Tests
^^^^^


* **devtools:** more tests (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/a9b2fa7>`_\ )

BREAKING CHANGES
^^^^^^^^^^^^^^^^


* **formula:** consolidation of states under few headings

`1.6.1 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.6.0...v1.6.1>`_ (2020-07-10)
------------------------------------------------------------------------------------------------------------

Documentation
^^^^^^^^^^^^^


* **readme:** expanded documentation (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/8cae5c7>`_\ )

`1.6.0 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.5.0...v1.6.0>`_ (2020-07-10)
------------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **macos:** resolve `#31 <https://github.com/saltstack-formulas/kubernetes-formula/issues/31>`_ (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/ecd83ac>`_\ )
* **syntax:** get travis ci passing (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/85969de>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **devtools:** consoldiate states (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/4ae1c36>`_\ )
* **tools:** rename to devtools (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/acab20b>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **redhat:** standalone centos/fedora tests (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/ac0d984>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** fix readme (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/0ba0b77>`_\ )

Features
^^^^^^^^


* **devtools:** add kubectx, kubens (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/b81b6ac>`_\ )
* **istio:** support istio archive (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/6565ac2>`_\ )
* **linkerd:** add linkerd2 support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/80858a4>`_\ )
* **octant:** add vmware-tanzur/octant support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/dd55b72>`_\ )
* **operators:** support for kubernetes operators (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/d3f30c7>`_\ )

`1.5.0 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.4.1...v1.5.0>`_ (2020-07-09)
------------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **clientlibs:** kubernetes api client libs (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/983227e>`_\ )
* **kind:** add kind support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/b4cdb90>`_\ )

`1.4.1 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.4.0...v1.4.1>`_ (2020-07-08)
------------------------------------------------------------------------------------------------------------

Code Refactoring
^^^^^^^^^^^^^^^^


* **kubernetes:** add server, client, node states (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/49eb3b2>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **alternatives:** test for kubebuilder linux alternatives (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/c8431fd>`_\ )
* **tests:** fix failures (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/8a787d8>`_\ )

`1.4.0 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.3.0...v1.4.0>`_ (2020-07-07)
------------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **utils:** kubebuilder support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/6995116>`_\ )

`1.3.0 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.2.1...v1.3.0>`_ (2020-07-07)
------------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **state:** package repo fix (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/ee37c64>`_\ )

Features
^^^^^^^^


* **kubecli:** add kubeadm/kubelet support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/c0159c3>`_\ )

`1.2.1 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.2.0...v1.2.1>`_ (2020-07-06)
------------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **macos:** add fullpath to brew (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/8edae91>`_\ )
* **macos:** fix group (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/936ae46>`_\ )

`1.2.0 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.1.0...v1.2.0>`_ (2020-07-06)
------------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **kudo:** add kubectl-kudo support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/73c1930>`_\ )

`1.1.0 <https://github.com/saltstack-formulas/kubernetes-formula/compare/v1.0.0...v1.1.0>`_ (2020-07-06)
------------------------------------------------------------------------------------------------------------

Code Refactoring
^^^^^^^^^^^^^^^^


* **formula:** simplify; add devspace, k3s; expand tests (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/fea0ce2>`_\ )

Features
^^^^^^^^


* **devspace:** add devspace support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/e7629b7>`_\ )

1.0.0 (2020-07-01)
------------------

Bug Fixes
^^^^^^^^^


* **issues:** second commit (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/71f170e>`_\ )
* **jinja:** corrected jinja variables and logic (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/19b3136>`_\ )
* **jinja:** rename conflicting stuff (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/9fadf37>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **config:** simplify & fix config states (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/71101dc>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **travis:** install conntracker; setup k8s env (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/4af876b>`_\ )
* **travis:** update kitchen platforms (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/7903ef7>`_\ )
* **travis:** update travis tests (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/5e356be>`_\ )
* **travis:** update travis tests (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/583bdec>`_\ )

Features
^^^^^^^^


* **formula:** first commit (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/c173a4a>`_\ )
* **semantic-release:** standardise for this formula (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/9ed2025>`_\ )
* **suse:** add suse os support (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/2c32d33>`_\ )
* **suse:** corrected url for source code (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/26adc3f>`_\ )

Tests
^^^^^


* **kitchen:** add ci support; align to template-formula (\ ` <https://github.com/saltstack-formulas/kubernetes-formula/commit/5cbeb37>`_\ )

BREAKING CHANGES
^^^^^^^^^^^^^^^^


* **kitchen:** Major refactor of formula to bring it in alignment with the
  template-formula. As with all substantial changes, please ensure your
  existing configurations work in the ways you expect from this formula.

refactor(symlink): ensure symlink is managed good
