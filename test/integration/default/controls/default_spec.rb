# frozen_string_literal: true

title 'kubernetes archives profile'

control 'kubernetes archive' do
  impact 1.0
  title 'should be installed'

  describe file('/usr/local/kubectl-v1.18.2/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/kubectl-v1.18.2/bin/kubectl') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/kubectl') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/etc/default/kubectl.sh') do
    it { should exist }
  end
  describe file('/usr/local/minikube-v1.9.2/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/minikube-v1.9.2/bin/minikube') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/minikube') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/usr/local/devspace-v4.13.1/bin') do
    it { should exist }
    it { should be_directory }
    its('type') { should eq :directory }
  end
  describe file('/usr/local/devspace-v4.13.1/bin/devspace') do
    it { should exist }
    its('mode') { should cmp '0755' }
  end
  describe file('/usr/local/bin/devspace') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
  # describe file('/usr/local/k3s-v1.18.4+k3s1/bin') do
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
  describe file('/usr/local/bin/kubebuilder') do
    it { should be_file }
    it { should_not be_directory }
  end
end
