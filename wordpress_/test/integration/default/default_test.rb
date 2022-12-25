# Chef InSpec test for recipe wordpress::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe file('/etc/wordpress') do 
   it { should be_file }
   its('content'){ should match(/.+/)}
end


# This is an example test, replace it with your own test.
#describe port(80), :skip do
#  it { should_not be_listening }
#end
