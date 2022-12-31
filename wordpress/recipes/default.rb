#
# Cookbook:: wordpress
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.
cookbook_file '/etc/wordpress' do 
   source 'wordpress'
   mode '0644'
end



apt_update 'Update the apt cache daily' do
   frequency 86_400
   action :periodic
end

include_recipe '::apache2'
include_recipe '::mysql'
include_recipe '::php'
package 'curl'

server_fqdn = node['fqdn']

remote_file "#{Chef::Config[:file_cache_path]}/latest.tar.gz" do
  source "http://wordpress.org/latest.tar.gz"
  mode "0644"
end

directory "#{node['wordpress']['dir']}" do
  owner "root"
  group "root"
  mode "0755"
  action :create
  recursive true
end

execute "untar-wordpress" do
   command "tar --strip-components 1 -xzf #{Chef::Config[:file_cache_path]}/latest.tar.gz"
   cwd node['wordpress']['dir']
   creates "#{node['wordpress']['dir']}/wp-settings.php"
end

remote_file "#{Chef::Config[:file_cache_path]}/wp-cli.phar" do
  source "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
  mode "0644"
end

execute "mv #{Chef::Config[:file_cache_path]}/wp-cli.phar /usr/local/bin/wp" do
   not_if { File.exist?("/usr/local/bin/wp") }
end

file '/usr/local/bin/wp' do
   mode '777'
 end

 execute "cofig user" do
   command ' cd #{node[\'wordpress\'][\'dir\']}  && sudo wp config create --dbname=#{node[\'wordpress\'][\'db\'][\'database\']} --dbuser=root --allow-root   && sudo  wp config set DB_NAME #{node[\'wordpress\'][\'db\'][\'database\']} --allow-root && sudo  wp config set DB_USER #{node[\'wordpress\'][\'db\'][\'user\']}  --allow-root && sudo  wp config set  DB_PASSWORD #{node[\'wordpress\'][\'db\'][\'password\']}   --allow-root && sudo  wp config set  DB_HOST -\'localhost\'  --allow-root && sudo  wp config set  FORCE_SSL_LOGIN true  --allow-root && sudo  wp config set  FORCE_SSL_ADMIN true  --allow-root && sudo  wp config set  CONCATENATE_SCRIPTS true  --allow-root &&  sudo  wp config set  SCRIPT_DEBUG true  --allow-root'
end

execute "wp-user-settings" do
   command ' cd #{node[\'wordpress\'][\'dir\']}  && sudo  wp core install  --title=#{node[\'wordpress\'][\'title_wp\']} --admin_user=#{node[\'wordpress\'][\'user_wp\']} --admin_password=#{node[\'wordpress\'][\'db\'][\'password\']} --admin_email=#{node[\'wordpress\'][\'user_wp\']}@gmail.com  --url=http://=#{node[\'wordpress\'][\'url\']}/  --allow-root'
end

execute "wp-theme-settings" do
   command 'cd #{node[\'wordpress\'][\'dir\']}  && sudo  wp theme install wp-bootstrap-starter --activate  --allow-root'
end  

execute "wp-theme-create" do
   command 'cd #{node[\'wordpress\'][\'dir\']}  &&  sudo  wp post create --post_status=\'publish\' --post_title=#{node[\'wordpress\'][\'name_post\']} --post_content=#{node[\'wordpress\'][\'name_post\']}  --allow-root'
end
