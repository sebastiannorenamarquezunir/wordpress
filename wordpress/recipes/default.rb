#
# Cookbook:: wordpress
# Recipe:: default
# 
# Copyright:: 2022, The Authors, All Rights Reserved.
cookbook_file '/etc/wordpress' do 
   source 'wordpress'
   mode '0644'
end

directory "#{node['wordpress']['dir']}" do
  owner "root"
  group "root"
  mode "0777"
  action :create
  recursive true
end

apt_update 'Update the apt cache daily' do
   frequency 86_400
   action :periodic
end

if platform?('centos')
   include_recipe '::httpd'
   include_recipe '::mariadb'
 else
   include_recipe '::apache2'
   include_recipe '::mysql'
 end


include_recipe '::php'
package 'curl'

server_fqdn = node['fqdn']

if platform?('centos')
   remote_file "#{Chef::Config[:file_cache_path]}/wp-cli.phar" do
      source "https://github.com/wp-cli/wp-cli/releases/download/v2.0.0/wp-cli-2.0.0.phar"
      mode "0644"
   end
   execute "sudo mv #{Chef::Config[:file_cache_path]}/wp-cli.phar /usr/local/bin/wp-cli" do
      not_if { File.exist?("/usr/local/bin/wp-cli") }
   end

   file '/usr/local/bin/wp-cli' do
      mode '777'
   end
 else
   remote_file "#{Chef::Config[:file_cache_path]}/wp-cli.phar" do
      source "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"
      mode "0644"
   end
   
   execute "sudo mv #{Chef::Config[:file_cache_path]}/wp-cli.phar /usr/local/bin/wp" do
      not_if { File.exist?("/usr/local/bin/wp") }
   end

   file '/usr/local/bin/wp' do
      mode '777'
   end
 end



if platform?('ubuntu')
   execute "create database" do
      command "sudo mysql --user=root --password=#{node['wordpress']['db']['password']} --execute=\"create database IF NOT EXISTS #{node['wordpress']['db']['database']};CREATE USER IF NOT EXISTS #{node['wordpress']['db']['user']}@localhost;SET PASSWORD FOR #{node['wordpress']['db']['user']}@localhost = \'#{node['wordpress']['db']['password']}\';GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON #{node['wordpress']['db']['database']}.* TO #{node['wordpress']['db']['user']}@localhost;FLUSH PRIVILEGES;\""
   end

   execute 'Execute a shell' do
      command "bash -c \"cd #{node['wordpress']['dir']} && sudo wp core download --allow-root && sudo wp config create --dbname=#{node['wordpress']['db']['database']} --dbuser=root --allow-root && sudo  wp config set DB_NAME #{node['wordpress']['db']['database']} --allow-root && sudo  wp config set DB_USER #{node['wordpress']['db']['user']}  --allow-root && sudo wp config set  DB_PASSWORD #{node['wordpress']['db']['password']}  --allow-root && sudo wp config set  DB_HOST localhost  --allow-root && sudo  wp config set  FORCE_SSL_LOGIN true  --allow-root && sudo  wp config set  FORCE_SSL_ADMIN true  --allow-root && sudo  wp config set  CONCATENATE_SCRIPTS true  --allow-root  && sudo  wp config set  SCRIPT_DEBUG true  --allow-root  && sudo  wp config set  FORCE_SSL_ADMIN true  --allow-root  \" "
      not_if { File.exist?("/var/www/wordpress/wp-config.php") }
   end

   execute 'Execute create file' do
      command "bash -c \"cd #{node['wordpress']['dir']} && sudo  wp core install --title=\'#{node['wordpress']['title_wp']}\' --admin_user=\'#{node['wordpress']['user_wp']}\' --admin_password=\'#{node['wordpress']['db']['password']}\' --admin_email=\'#{node['wordpress']['user_wp']}@gmail.com\'  --url=\'http://#{node['wordpress']['url']}\'  --allow-root \" "
   end

   execute 'theme' do
      command "bash -c \"cd #{node['wordpress']['dir']} && sudo  wp theme install wp-bootstrap-starter --activate  --allow-root && sudo  wp post create --post_status='publish' --post_title\'node['wordpress']['name_post']}\' --post_content=\'#{node['wordpress']['name_post']}\'  --allow-root \" "
   end

end



