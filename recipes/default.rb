node.default['apache']['version'] = '2.4'

include_recipe "apache2"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"

include_recipe "devbox::basic"
include_recipe "devbox::awscli"

#apache_site "default" do
#  enable false
#end

# Required extensions
%w{mysql-server-5.6 mysql-client-5.6 php5-curl php5-gd php5-mcrypt php5-redis}.each do |package|
  package "#{package}" do
    action :install
  end
end

execute "install mcrypt" do
  command "php5enmod mcrypt"
  user 'root'
  notifies :restart, "service[apache2]", :delayed
end


include_recipe "devbox::instances"
include_recipe "devbox::users_groups"
