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

package 'git'
package 'tree'
package 'curl'