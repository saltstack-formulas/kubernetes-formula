# frozen_string_literal: true

title 'kubernetes sources profile'

control 'kubernetes source' do
  impact 1.0
  title 'should be installed'

  describe file('/etc/default/kubectl.sh') do
    it { should exist }
  end
  describe file('/etc/default/minikube.sh') do
    it { should exist }
  end
end
