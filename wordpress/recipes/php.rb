#
# Cookbook:: wordpress
# Recipe:: php
#
# Copyright:: 2022, The Authors, All Rights Reserved.
# install php.
package "php" do
    action :install
end
package "php-pear" do
    action :install
end

if platform?('centos')
    package 'php-pspell' do
        action :install
    end
    package 'php-xmlrpc' do
        action :install
    end
  else
    package 'libapache2-mod-php' do
        action :install
    end
  end

# Install php-mysql.
package 'php-mysql' do
    action :install
end