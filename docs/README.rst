.. _readme:

kubernetes-formula
==================

Formula to manage kubernetes on MacOS and GNU/Linux. Currently supports:

* `devspace`
* `k3s`
* `kubebuilder`
* `kubectl`
* `kubeadm`
* `kubelet`
* `minikube`
* `kudo`


|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/kubernetes-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/kubernetes-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula for kubernetes on MacOS and GNU/Linux.

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.  If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_. If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``, which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.  See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see :ref:`How to contribute <CONTRIBUTING>` for more details.

Available Meta states
----------------------

.. contents::
   :local:

``kubernetes``
^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state installs the kubernetes solution.

``kubernetes.clean``
^^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state removes the kubernetes solution.

``kubernetes.kubectl``
^^^^^^^^^^^^^^^^^^^^^^

This state installs kubernetes-cli only.

``kubernetes.kubectl.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubernetes-cli only.

``kubernetes.kubeadm``
^^^^^^^^^^^^^^^^^^^^^^

This state installs kubeadm on supported GNU/Linux only.

``kubernetes.kubeadm.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubeadm on supported GNU/Linux only.

``kubernetes.kubelet``
^^^^^^^^^^^^^^^^^^^^^^

This state installs kubelet on supported GNU/Linux only.

``kubernetes.kubelet.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kublet on supported GNU/Linux only.

``kubernetes.minikube``
^^^^^^^^^^^^^^^^^^^^^^^

This state installs minikube only.

``kubernetes.minikube.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls minikube only.

``kubernetes.devspace``
^^^^^^^^^^^^^^^^^^^^^^^

This state installs devspace only.

``kubernetes.devspace.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubernetes devspace only.

``kubernetes.k3s``
^^^^^^^^^^^^^^^^^^

This state installs k3s only.

``kubernetes.k3s.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls k3s only.

``kubernetes.kudo``
^^^^^^^^^^^^^^^^^^^

This state installs kudo only.

``kubernetes.kudo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kudo only.

``kubernetes.kubebuilder``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubebuilder only.

``kubernetes.kubebuilder.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubebuilder only.


Main Sub-states
---------------

.. contents::
   :local:

``kubernetes.minikube.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs minikube package only (MacOS).

``kubernetes.minikube.package.repo``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs minikube package repository only.

``kubernetes.minikube.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state removes minikube package repository only.

``kubernetes.minikube.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls the minikube package only (MacOS).

``kubernetes.minikube.binary``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs minikube binary only.

``kubernetes.minikube.binary.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls minikube binary only.

``kubernetes.kubectl.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubectl package only.

``kubernetes.kubectl.package.repo``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubectl package repository only.

``kubernetes.kubectl.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state removes kubectl package repository only.

``kubernetes.kubectl.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubectl package only.

``kubernetes.kubectl.binary``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubectl binary only.

``kubernetes.kubectl.binary.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubectl binary only.

``kubernetes.devspace.binary``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs devspace binary only.

``kubernetes.devspace.binary.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls devspace binary only.

``kubernetes.k3s.binary``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs k3s binary only.

``kubernetes.k3s.binary.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls k3s binary only.

``kubernetes.k3s.script``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs k3s script only.

``kubernetes.k3s.script.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls k3s script only.

``kubernetes.kudo.binary``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kudo binary only.

``kubernetes.kudo.binary.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kudo binary only.

``kubernetes.kudo.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kudo package only.

``kubernetes.kudo.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kudo package only.

``kubernetes.kubebuilder.archive``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubebuilder archive and linux alternatives.

``kubernetes.kubebuilder.archive.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubebuilder archive  only.

``kubernetes.kubebuilder.archive.alternatives``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubebuilder linux alternatives only.

``kubernetes.kubebuilder.archive.alternatives.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubebuilder linux alternatives only.



Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``kubernetes`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

