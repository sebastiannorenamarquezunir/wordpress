# Chef InSpec test for recipe wordpress::php

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe package('php') do
  it { should be_installed }
end
