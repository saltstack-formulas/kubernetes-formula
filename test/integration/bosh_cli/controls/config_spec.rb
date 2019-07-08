control 'kubernetes bosh cli' do
  title 'should match desired lines'

  describe file('/usr/local/bin/bosh') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0555' }
  end
end
