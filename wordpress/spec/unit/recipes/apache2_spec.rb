#
# Cookbook:: wordpress
# Spec:: apache2
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'wordpress::apache2' do
  context 'When all attributes are default, on Ubuntu 20.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'ubuntu', '20.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on CentOS 8' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/main/PLATFORMS.md
    platform 'centos', '8'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'Pakage apache2 is present' do
    it 'install a package apache2' do
      expect(chef_run).to install_package('apache2')
    end
  end

  context 'Configuration files' do
    it 'Delete 000-default.conf file' do
      expect(chef_run).to delete_file('/etc/apache2/sites-enabled/000-default.conf')
    end
    it 'creates a template with the default action' do
      expect(chef_run).to create_template('/etc/apache2/sites-available/vagrant.conf')
    end
  end

  context 'Apache2 available' do
    it 'Apache2 is running' do
      expect(chef_run).to start_service('apache2')
    end
  end
end