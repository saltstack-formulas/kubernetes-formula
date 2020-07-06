
Changelog
=========

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
