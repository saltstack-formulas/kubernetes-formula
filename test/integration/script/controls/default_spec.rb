# frozen_string_literal: true

title 'kubernetes archives profile'

control 'kubernetes archive' do
  impact 1.0
  title 'should be installed'

  describe file('/etc/systemd/system/k3s.service') do
    it { should exist }
    it { should_not be_directory }
    its('type') { should eq :file }
  end
  describe file('/usr/local/bin/k3s-killall.sh') do
    it { should exist }
    it { should_not be_directory }
    its('type') { should eq :file }
  end
  describe file('/etc/rancher/k3s/k3s.yaml') do
    it { should exist }
    it { should_not be_directory }
    its('type') { should eq :file }
  end
  describe file('/usr/local/bin/k3s') do
    it { should be_file }
    it { should_not be_directory }
  end
  describe file('/etc/rancher/k3s') do
    it { should be_directory }
    it { should_not be_file }
  end
  describe file('/var/lib/rancher/k3s/server/cred/admin.kubeconfig') do
    it { should exist }
    it { should_not be_directory }
    its('type') { should eq :file }
  end
  describe file('/var/lib/rancher/k3s/agent/k3scontroller.kubeconfig') do
    it { should exist }
    it { should_not be_directory }
    its('type') { should eq :file }
  end
  describe file('/var/lib/rancher/k3s/server/node-token') do
    it { should be_symlink }
    it { should be_file }
    it { should_not be_directory }
  end
end
