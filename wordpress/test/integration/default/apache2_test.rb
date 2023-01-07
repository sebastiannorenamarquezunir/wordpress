# Chef InSpec test for recipe wordpress::apache2

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

if os[:family] =='ubuntu'
    describe package('apache2') do
      it { should be_installed }
    end

    describe file('/etc/apache2/sites-enabled/000-default.conf') do
      it { should_not exist }
    end

    describe file('/etc/apache2/sites-available/vagrant.conf') do
      it { should exist }
    end

    describe service('apache2') do
      it { should be_enabled }
      it { should be_running }
    end

    describe port(80) do
      it { should be_listening }
      its('protocols') { should include 'tcp' }
      its('addresses') { should include '0.0.0.0' }
    end

    describe port(22) do
      it { should be_listening }
      its('processes') { should include 'sshd' }
      its('protocols') { should include 'tcp' }
      its('addresses') { should include '0.0.0.0' }
    end
end