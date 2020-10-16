.. _readme:

kubernetes-formula
==================

Extensible formula to manage kubernetes on MacOS, Windows, and GNU/Linux. Currently supports:

* `server`  (https://kubernetes.io)
* `node`    (https://kubernetes.io)
* `client`  (https://kubernetes.io, aliases)
* `operator` (sdk, etc)
* `operators` (https://operatorhub.io)
* `devtools` (extensive collection of tools, kubectx, kubens, cue, attr2rbac, dive, stern, etc)
* `devlibs`  (kubernetes clients, source software)
* `sigs`  (https://github.com/kubernetes-sigs, special interest groups)


The default `kubernetes.sigs` state includes the following:

* `kind` (https://github.com/kubernetes-sigs/kind)
* `krew` (https://github.com/kubernetes-sigs/krew
* `kubebuilder` (https://github.com/kubernetes-sigs/kubebuilder


The default `kubernetes.devtools` state includes the following:

* `devspace`  (https://devspace.sh)
* `istio`  (https://istio.io) 
* `kind`  (https://github.com/kubernetes-sigs/kind)
* `k3s`   (https://k3s.io)
* `kudo`   (https://kudo.dev)
* `kubebuilder`  (https://github.com/kubernetes-sigs/kubebuilder)
* `linkerd2`  (https://linkerd.io)
* `minikube`  (https://github.com/kubernetes/minikube)
* `octant`    (https://github.com/vmware-tanzu/octant)
* `skaffold`  (https://skaffold.dev)


The default `kubernetes.operator` state includes:

* `sdk` (https://sdk.operatorframework.io/)


The default `kubernetes.operators` state includes (from https://operatorhub.io):

* `akka-cluster` (https://github.com/lightbend/akka-cluster-operator)
* `grafana` (https://github.com/integr8ly/grafana-operator)
* `prometheus` (https://github.com/coreos/prometheus-operator)
* `istio` (https://github.com/banzaicloud/istio-operator)
* `shell-operator` (https://github.com/flant/shell-operator)


The default `kubernetes.devlibs` state includes the following:

* `Java client library for kubernetes` (https://github.com/kubernetes-client/java)
* `Python client library for kubernetes` (https://github.com/kubernetes-client/python)
* `Csharp client library for kubernetes` (https://github.com/kubernetes-client/csharp)
* `Javascript client library for kubernetes` (https://github.com/kubernetes-client/javascript)
* `Python kubernetes-operator library` (https://github.com/zalando-incubator/kopf)
* `Simple kubernetes Go client` (https://github.com/ericchiang/k8s)


|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/kubernetes-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/kubernetes-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula for kubernetes on MacOS, GNU/Linux and Windows.

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

This state installs the kubernetes solution (see https://kubernetes.io)

``kubernetes.clean``
^^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state removes the kubernetes solution.

``kubernetes.package.repo``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubernetes package repository only (see https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-using-native-package-management)

``kubernetes.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state removes kubernetes package repository only.

``kubernetes.client``
^^^^^^^^^^^^^^^^^^^^^^

This state installs kubernetes cli and libraries only  (see https://kubernetes.io/docs/reference/kubectl, (https://kubernetes.io/docs/setup/release/notes/#client-binaries, and https://kubernetes.io/docs/reference/using-api/client-libraries)

``kubernetes.client.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubernetes cli and libraries only.

``kubernetes.server``
^^^^^^^^^^^^^^^^^^^^^

This state installs kubernetes server GNU/Linux only (see https://kubernetes.io and https://kubernetes.io/docs/setup/release/notes/#server-binaries)

``kubernetes.server.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubernetes server GNU/Linux only.

``kubernetes.node``
^^^^^^^^^^^^^^^^^^^

This state installs kubernetes node on Windows/MacOS/Linux only (see https://kubernetes.io/docs/concepts/architecture/nodes)

``kubernetes.node.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubernetes node on Windows/MacOS/Linux only.

``kubernetes.sigs``
^^^^^^^^^^^^^^^^^^^

This state installs kubernetes sig archives only

``kubernetes.sigs.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubernetes sig archives only

``kubernetes.operator``
^^^^^^^^^^^^^^^^^^^^^^^^

This state installs operator archives only (Linux/MacOS)

* sdk (https://sdk.operatorframework.io)

``kubernetes.operator.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls operator archives only (Linux/MacOS)

* sdk (https://sdk.operatorframework.io)

``kubernetes.operators``
^^^^^^^^^^^^^^^^^^^^^^^^

This state installs operator archives only

* https://operatorhub.io
* https://github.com/flant/shell-operator
* https://github.com/ahmetb/kubectx

``kubernetes.operators.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls operator archives only

``kubernetes.devtools``
^^^^^^^^^^^^^^^^^^^^^^^

This state installs selected kubernetes developer tools only

* https://github.com/ahmetb/kubectx
* https://github.com/cuelang/cue
* https://github.com/liggitt/audit2rbac
* https://github.com/wagoodman/dive
* https://github.com/wercker/stern
* https://github.com/kubernetes/minikube
* https://devspace.sh
* https://k3s.io
* https://kudo.dev
* https://github.com/kubernetes-sigs/kind
* https://github.com/kubernetes-sigs/kubebuilder
* https://istio.io
* https://github.com/vmware-tanzu/octant
* https://linkerd.io, and https://github.com/linkerd/linkerd2
* https://github.com/GoogleContainerTools/skaffold

``kubernetes.devtools.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls selected kubernetes developer tools only

``kubernetes.devlibs``
^^^^^^^^^^^^^^^^^^^^^^

This state installs selected kubernetes developer libraries

* https://github.com/kubernetes-client
* https://github.com/zalando-incubator/kopf
* https://github.com/ericchiang/k8s
* https://github.com/ahmetb/kubectl-aliases

``kubernetes.devlibs.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls selected kubernetes developer libraries (i.e. kubernetes client libraries, kopf, etc).


Main Sub-states
---------------

This list may be incomplete.

.. contents::
   :local:

``kubernetes.server.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs server packages from repo.

``kubernetes.server.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls server packages only 

``kubernetes.server.archive``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs server archive only

``kubernetes.server.archive.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls server archive only

``kubernetes.node.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs node packages from repo.

``kubernetes.node.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls node packages only 

``kubernetes.node.archive``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs node archive only

``kubernetes.node.archive.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls node archive only

``kubernetes.client.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubectl package only from repo.

``kubernetes.client.aliases``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubernetes developer aliases to /etc/defaults.

* https://github.com/ahmetb/kubectl-aliases

``kubernetes.client.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubectl package only

``kubernetes.client.archive``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubectl archive only

``kubernetes.client.archive.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubectl archive only

``kubernetes.client.binary``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs kubectl binary only

``kubernetes.client.binary.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls kubectl binary only

``kubernetes.k3s.binary``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs k3s binary only

``kubernetes.k3s.binary.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls k3s binary only

``kubernetes.k3s.script``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs k3s script only

``kubernetes.k3s.script.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls k3s script only



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

