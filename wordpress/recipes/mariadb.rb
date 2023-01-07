#
# Cookbook:: wordpress
# Recipe:: mysql
#
# Copyright:: 2022, The Authors, All Rights Reserved.
# Configure the MySQL client.
  %w{mariadb mariadb-server}.each do |pkg|
    package pkg do
      action :install
    end
  end

  service 'mariadb' do
    action [:enable, :start]
  end
   
# Location of the initial MySQL script
template '/tmp/mysql.sql' do
  source "mysql.conf.erb"
end
 
# Execute the initial setup of MySQL
execute 'mysql_server' do
  command '/usr/bin/mysql -sfu root < /tmp/mysql.sql && ls /tmp/mysql.sql'
  ignore_failure true
end