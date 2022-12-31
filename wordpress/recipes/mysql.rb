#
# Cookbook:: wordpress
# Recipe:: mysql
#
# Copyright:: 2022, The Authors, All Rights Reserved.
# Configure the MySQL client.
  package 'mysql-server' do
    action :install
  end