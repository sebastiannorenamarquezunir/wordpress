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
package 'libapache2-mod-php' do
  action :install
end
# Install php-mysql.
package 'php-mysql' do
    action :install
end