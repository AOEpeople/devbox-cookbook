node.default['apache']['version'] = '2.4'

include_recipe "apache2"
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"
include_recipe "database::mysql"

include_recipe "devbox::basic"
include_recipe "devbox::awscli"

#apache_site "default" do
#  enable false
#end

# Required extensions
%w{php5-curl php5-gd php5-mcrypt php5-redis}.each do |package|
  package "#{package}" do
    action :install
  end
end

execute "install mcrypt" do
  command "php5enmod mcrypt"
  user 'root'
  notifies :restart, "service[apache2]", :delayed
end

Chef::Log.info("Preparing Magento instances");

sites = data_bag(node['devbox']['magento_instances_databag_name'])
sites.each do |site|
  opts = data_bag_item(node['devbox']['magento_instances_databag_name'], site)

  Chef::Log.info("Found Magento site #{opts["id"]}")

  devbox_magento_vhost "#{opts["project"]}_#{opts["environment"]}" do
    project opts["project"]
    environment opts["environment"]
    server_name opts["server_name"]
  end

  opts["prepare_systemstorages"].each do |name|
    devbox_systemstorage "#{opts["project"]}_#{name}" do
      project opts["project"]
      environment name
    end
  end

  opts["databases"].each do |dbname|
    devbox_magento_db dbname
  end

end

include_recipe "devbox::users_groups"