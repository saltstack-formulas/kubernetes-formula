# frozen_string_literal: true

title 'kubernetes archives profile'

control 'kubernetes archive' do
  impact 1.0
  title 'should be installed'

  describe file('/usr/local/k8s-server-1.22.1/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/kubeadm') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/apiextensions-apiserver') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/mounter') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/kube-controller-manager') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/kubelet') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/kube-apiserver') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/kube-proxy') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/kube-scheduler') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/kubectl') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/kubectl') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-server-1.22.1/bin/kubectl') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-node-1.22.1/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/k8s-node-1.22.1/bin/kubeadm') do
    it { should exist }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-node-1.22.1/bin/kubectl') do
    it { should exist }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-node-1.22.1/bin/kube-proxy') do
    it { should exist }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-node-1.22.1/bin/kubelet') do
    it { should exist }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-node-1.22.1/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/k8s-sigs-kind-0.11.1/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/k8s-sigs-kind-0.11.1/bin/kind') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/kind') do
    # it { should be_symlink }
    it { should_not be_directory }
  end
    describe file('/opt/intel/bin/cri-resmgr') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/cri-resmgr') do
    # it { should be_symlink }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-stern-1.11.0/bin/stern') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/stern') do
    # it { should be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-node-1.22.1/bin/kubectl') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/k8s-client-1.22.1/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/k8s-client-1.22.1/bin/kubectl') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/kubectl') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-minikube-1.23.0/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/k8s-devtools-minikube-1.23.0/bin/minikube') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/minikube') do
    # it { should be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-devspace-5.15.0/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/k8s-devtools-devspace-5.15.0/bin/devspace') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/devspace') do
    # it { should be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-k3s-v1.21.4+k3s1/bin/k3s') do
    it { should exist }
    it { should_not be_directory }
    its('type') { should eq :file }
  end
  describe file('/usr/local/bin/k3s') do
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/kube-apiserver') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-kudo-0.19.0/bin/kudo') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/kudo') do
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-sigs-kubebuilder-3.1.0/bin/etcd') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-sigs-kubebuilder-3.1.0/bin/kube-apiserver') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-sigs-kubebuilder-3.1.0/bin/kubectl') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-sigs-kubebuilder-3.1.0/bin/kubebuilder') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/kubebuilder') do
    # it { should be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-istio-1.11.2/bin/istioctl') do
    it { should_not be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/istioctl') do
    # it { should be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-kubectx-0.9.4/bin/kubectx') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/kubectx') do
    # it { should be_symlink }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-kubens-0.9.4/bin/kubens') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/kubens') do
    # it { should be_symlink }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-cue-0.4.0/bin/cue') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/cue') do
    # it { should be_symlink }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-linkerd2-21.9.1') do
    it { should be_directory }
  end
  describe file('/usr/local/k8s-devtools-linkerd2-21.9.1/bin/linkerd2') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-audit2rbac-0.8.0') do
    it { should be_directory }
  end
  describe file('/usr/local/k8s-devtools-audit2rbac-0.8.0/bin/audit2rbac') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/audit2rbac') do
    # it { should be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-octant-0.23.0/bin/octant') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/octant') do
    # it { should be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-skaffold-1.31.0/bin/skaffold') do
    it { should be_file }
  end
  describe file('/usr/local/bin/skaffold') do
    # it { should be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-dive-0.10.0/bin/dive') do
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-devtools-dive-0.10.0') do
    it { should be_directory }
  end
  describe file('/usr/local/bin/dive') do
    # it { should be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/k8s-sigs-krew-0.4.1') do
    it { should be_directory }
  end
  describe file('/usr/local/bin/krew') do
    # it { should be_symlink }
    # it { should be_file }
    it { should_not be_directory }
  end
  describe file('/etc/default/kubernetes-aliases.sh') do
    it { should be_file }
  end
  describe file('/usr/local/src/k8s/libs/k8s-devlibs-kopf-0.27') do
    it { should be_directory }
  end
  describe file('/usr/local/src/k8s/libs/k8s-devlibs-csharp-1.2.0') do
    it { should be_directory }
  end
  describe file('/usr/local/src/k8s/libs/k8s-devlibs-python-18.20.0') do
    it { should be_directory }
  end
  describe file('/usr/local/src/k8s/libs/k8s-devlibs-java-13.0.0') do
    it { should be_directory }
  end
  describe file('/usr/local/src/k8s/libs/k8s-devlibs-javascript-0.15.0') do
    it { should be_directory }
  end
  # describe file('/usr/local/bin/ansible-operator') do
  #   it { should exist }
  #   its('mode') { should cmp '0755' }
  # end
  # describe file('/usr/local/bin/helm-operator') do
  #   it { should exist }
  #   its('mode') { should cmp '0755' }
  # end
  # describe file('/usr/local/bin/operator-sdk') do
  #   it { should exist }
  #   its('mode') { should cmp '0755' }
  # end
  describe file('/usr/local/src/k8s/libs/k8s-operators-istio-operator-0.10.6') do
    it { should be_directory }
  end
  describe file('/usr/local/src/k8s/libs/k8s-operators-akka-cluster-operator-1.0.3') do
    it { should be_directory }
  end
  describe file('/usr/local/src/k8s/libs/k8s-operators-prometheus-operator-0.50.0') do
    it { should be_directory }
  end
  describe file('/usr/local/src/k8s/libs/k8s-operators-grafana-operator-3.10.3') do
    it { should be_directory }
  end
end
