# frozen_string_literal: true

title 'kubernetes archives profile'

control 'kubernetes archive' do
  impact 1.0
  title 'should be installed'

  describe file('/usr/local/kubernetes-server-v1.18.0/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/kubernetes-server-v1.18.0/bin/kubectl') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/kubernetes-node-v1.18.0/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/kubernetes-kind-v0.8.1/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/kubernetes-kind-v0.8.1/bin/kind') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/kubernetes-node-v1.18.0/bin/kubectl') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/kubernetes-client-v1.18.0/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/kubernetes-client-v1.18.0/bin/kubectl') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/kubectl') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/kubernetes-minikube-v1.9.2/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/kubernetes-minikube-v1.9.2/bin/minikube') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/minikube') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/kubernetes-devspace-v4.13.1/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/kubernetes-devspace-v4.13.1/bin/devspace') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/devspace') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  # describe file('/usr/local/kubernetes-k3s-v1.18.4+k3s1/bin') do
  #   it { should exist }
  #   it { should be_directory }
  #   its('type') { should eq :directory }
  # end
  describe file('/tmp/kubernetes-tmp/k3s-bootstrap.sh') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/k3s') do
    it { should be_file }
    it { should_not be_directory }
  end
  # describe file('/usr/bin/crictl') do
  # describe file('/usr/local/bin/crictl') do
  #   it { should be_file }
  #   it { should_not be_directory }
  # end
  describe file('/usr/local/bin/ctr') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/k3s-killall.sh') do
    it { should be_file }
  end
  describe file('/usr/local/bin/k3s-uninstall.sh') do
    it { should be_file }
  end
  describe file('/usr/local/bin/kubectl-kudo') do
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/etcd') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/kube-apiserver') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/kubebuilder') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/kind') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/kubernetes-linkerd2-v20.7.1/bin/linkerd') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/linkerd') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/kubernetes-istio-v1.6.4/bin/istioctl') do
    it { should_not be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/bin/istioctl') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/src/kubernetes/python') do
    it { should be_directory }
  end
  describe file('/usr/local/src/kubernetes/java') do
    it { should be_directory }
  end
  describe file('/usr/local/src/kubernetes/javascript') do
    it { should be_directory }
  end
  describe file('/usr/local/src/kubernetes/csharp') do
    it { should be_directory }
  end
end
