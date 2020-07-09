.. _readme:

kubernetes-formula
==================

Formula to manage kubernetes on MacOS and GNU/Linux. Currently supports:

* `server`
* `node`
* `client`
* `devspace`
* `kind`
* `k3s`
* `istio`
* `linkerd2`
* `kubebuilder`
* `minikube`
* `kudo`
* `client libs`


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

``kubernetes.package.repo``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubernetes package repository only.

``kubernetes.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state removes kubernetes package repository only.

``kubernetes.clean``
^^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state removes the kubernetes solution.

``kubernetes.client``
^^^^^^^^^^^^^^^^^^^^^^

This state installs kubernetes-cli only.

``kubernetes.client.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubernetes-cli only.

``kubernetes.server``
^^^^^^^^^^^^^^^^^^^^^

This state installs kubernetes server on supported GNU/Linux only.

``kubernetes.server.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubernetes server on supported GNU/Linux only.

``kubernetes.node``
^^^^^^^^^^^^^^^^^^^

This state installs kubernetes node on supported GNU/Linux only.

``kubernetes.node.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubernetes node on supported GNU/Linux only.

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

``kubernetes.kind``
^^^^^^^^^^^^^^^^^^^

This state installs kind only.

``kubernetes.kind.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kind only.

``kubernetes.kubebuilder``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubebuilder only.

``kubernetes.kubebuilder.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubebuilder only.

``kubernetes.istio``
^^^^^^^^^^^^^^^^^^^^

This state installs istio only.

``kubernetes.istio.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls istio only.

``kubernetes.linkerd2``
^^^^^^^^^^^^^^^^^^^^^^^

This state installs linkerd2 only.

``kubernetes.linkerd2.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls linkerd2 only.


Main Sub-states
---------------

.. contents::
   :local:

``kubernetes.minikube.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs minikube package only (MacOS).

``kubernetes.minikube.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls the minikube package only (MacOS).

``kubernetes.minikube.binary``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs minikube binary only.

``kubernetes.minikube.binary.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls minikube binary only.

``kubernetes.server.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs server packages from repo.

``kubernetes.server.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls server packages only.

``kubernetes.server.archive``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs server archive only.

``kubernetes.server.archive.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls server archive only.

``kubernetes.node.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs node packages from repo.

``kubernetes.node.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls node packages only.

``kubernetes.node.archive``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs node archive only.

``kubernetes.node.archive.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls node archive only.

``kubernetes.client.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubectl package only from repo.

``kubernetes.client.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubectl package only.

``kubernetes.client.archive``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubectl archive only.

``kubernetes.client.archive.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubectl archive only.

``kubernetes.client.binary``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubectl binary only.

``kubernetes.client.binary.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

``kubernetes.client.libs``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubernetes api client libs only.

``kubernetes.client.libs.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state removes kubernetes api client libs directory only.



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

