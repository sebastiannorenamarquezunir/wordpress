#
# Cookbook:: wordpress
# Spec:: php
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'wordpress::php' do
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

  context 'Pakage libapache2-mod-php is present' do
    platform 'centos', '8'
    it 'install a package libapache2-mod-php' do
      expect(chef_run).to install_package('libapache2-mod-php')
    end
  end

  context 'Pakage libapache2-mod-php is present' do
    platform 'ubuntu', '20.04'
    it 'install a package libapache2-mod-php' do
      expect(chef_run).to install_package('libapache2-mod-php')
    end
  end

  context 'Pakage php is present' do
    platform 'centos', '8'
    it 'install a package php' do
      expect(chef_run).to install_package('php')
    end
  end

  context 'Pakage php is present' do
    platform 'ubuntu', '20.04'
    it 'install a package php' do
      expect(chef_run).to install_package('php')
    end
  end
  
  context 'Pakage php-pear is present' do
    platform 'centos', '8'
    it 'install a package php-pear' do
      expect(chef_run).to install_package('php-pear')
    end
  end

  context 'Pakage php-pear is present' do
    platform 'ubuntu', '20.04'
    it 'install a package php-pear' do
      expect(chef_run).to install_package('php-pear')
    end
  end

  context 'Pakage php-mysql is present' do
    platform 'centos', '8'
    it 'install a package php-mysql' do
      expect(chef_run).to install_package('php-mysql')
    end
  end

  context 'Pakage php-mysql is present' do
    platform 'ubuntu', '20.04'
    it 'install a package php-mysql' do
      expect(chef_run).to install_package('php-mysql')
    end
  end

end
