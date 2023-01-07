#
# Cookbook:: wordpress
# Recipe:: apache2
#
# Copyright:: 2022, The Authors, All Rights Reserved.
apt_update 'Update the apt cache daily' do
  frequency 86400
  action :periodic
end

package 'httpd' do
  action :install
end

service 'httpd' do
  action [ :enable, :start ]
end

execute 'httpd_firewall' do
  command '/usr/bin/firewall-cmd  --permanent --zone public --add-service http'
  ignore_failure true
end

execute 'reload_firewall' do
  command '/usr/bin/firewall-cmd --reload'
  ignore_failure true
end

file '/etc/httpd/conf/httpd.conf' do
  action :delete
end

template '/etc/httpd/conf/httpd.conf' do
  source 'virtual-hosts.conf.centos.erb'
  notifies :restart, resources(:service => 'httpd')
end


