# frozen_string_literal: true

title 'kubernetes package repo profile'

control 'kubernetes package repo' do
  impact 1.0
  title 'should be installed'

  describe file('/etc/default/kubectl.sh') do
    it { should exist }
  end
  describe file('/etc/default/minikube.sh') do
    it { should exist }
  end
  # describe file('/usr/local/bin/kubectl') do
  #   it { should exist }
  # end
  # describe file('/usr/local/bin/minikube') do
  #   it { should exist }
  # end
end
