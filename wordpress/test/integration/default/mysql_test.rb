# Chef InSpec test for recipe wordpress::mysql

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/


# This is an example test, replace it with your own test.
describe port(3306) do
  it { should be_listening }
  its('protocols') { should include 'tcp' }
end

describe package('mysql-server') do
  it { should be_installed }
end
