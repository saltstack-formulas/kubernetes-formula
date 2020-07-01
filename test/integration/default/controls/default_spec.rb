# frozen_string_literal: true

title 'kubernetes archives profile'

control 'kubernetes archive' do
  impact 1.0
  title 'should be installed'

  describe file('/etc/default/kubectl.sh') do
    it { should exist }
  end
  describe file('/etc/default/minikube.sh') do
    it { should exist }
  end
  # describe file('/usr/local/bin/kubectl') do
  #   its('link_path') { should eq '/opt/kubernetes/kubectl-v1.18.2/bin/kubectl' }
  # end
  # describe file('/usr/local/bin/minikube') do
  #   its('link_path') { should eq '/opt/kubernetes/minikube-v1.9.2/bin/minikube' }
  # end
end
