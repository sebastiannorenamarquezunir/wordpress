#
# Cookbook:: wordpress
# Spec:: mysql
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'wordpress::mysql' do
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

  context 'Pakage mysql-server is present' do
    platform 'centos', '8'
    it 'install a package mysql-server' do
      expect(chef_run).to install_package('mysql-server')
    end
  end

  context 'Pakage mysql-server is present' do
    platform 'ubuntu', '20.04'
    it 'install a package mysql-server' do
      expect(chef_run).to install_package('mysql-server')
    end
  end

end