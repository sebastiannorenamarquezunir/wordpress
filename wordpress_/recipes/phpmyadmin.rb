#
# Cookbook:: wordpress
# Recipe:: phpmyadmin
#
# Copyright:: 2022, The Authors, All Rights Reserved.
package "phpmyadmin" do
    action :install
end
execute "link_in_www" do
  command "sudo ln -s /usr/share/phpmyadmin/ /var/www/html"
  user "root"
  not_if { ::File.exist?('/var/www/html/phpmyadmin') }
end
# call passwords databags
passwords = data_bag_item('passwords', 'mysql')
template '/etc/phpmyadmin/config.inc.php' do
    variables(
      'phpmyadmin_password': passwords['root_password']
    )
    source 'phpmyadmin.config.inc.php.erb'
    action :create
end