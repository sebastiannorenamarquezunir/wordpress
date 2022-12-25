#
# Cookbook:: wordpress
# Recipe:: apache2
#
# Copyright:: 2022, The Authors, All Rights Reserved.
package "apache2" do
    action :install
end
service "apache2" do
    action [:enable, :start]
end