include_recipe "devbox::basic"
include_recipe "devbox::awscli"

# Required packages
%w{apache2 mysql-server-5.6 mysql-client-5.6 php5 php5-curl php5-gd php5-mcrypt php5-redis php5-mhash php5-cli php5-mysql php5-gd php5-intl php5-common}.each do |package|
  package "#{package}" do
    action :install
  end
end

execute "install mcrypt" do
  command "php5enmod mcrypt"
  user 'root'
  #notifies :restart, "service[apache2]", :delayed
end


include_recipe "devbox::instances"
include_recipe "devbox::users_groups"
