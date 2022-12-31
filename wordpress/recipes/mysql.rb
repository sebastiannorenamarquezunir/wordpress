#
# Cookbook:: wordpress
# Recipe:: mysql
#
# Copyright:: 2022, The Authors, All Rights Reserved.
# Configure the MySQL client.
  package 'mysql-server' do
    action :install
  end

  execute "Run_SQL_Files" do
    command "sudo mysql --user=root --password=#{node['wordpress']['db']['password']} --execute=\"create database IF NOT EXISTS #{node['wordpress']['db']['database']};CREATE USER IF NOT EXISTS #{node['wordpress']['db']['user']}@localhost;SET PASSWORD FOR #{node['wordpress']['db']['user']}@localhost =\'#{node['wordpress']['db']['password']}\';FLUSH PRIVILEGES;\""
  end