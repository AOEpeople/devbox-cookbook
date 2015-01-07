# Install packages
node['devbox']['packages'].each do |pkg|
  package pkg do
    action :upgrade
  end
end

# Install apache modules
node['devbox']['apache_modules'].each do |module|
  execute "Enable apache module #{module}" do
    command "a2enmod #{module}"
  end
end

# Install php modules
node['devbox']['php5_modules'].each do |module|
  execute "Enable php module #{module}" do
    command "php5enmod #{module}"
  end
end

# Add known hosts
node['devbox']['known_hosts'].each do |known_host|
  ssh_known_hosts_entry known_host
end

include_recipe "devbox::awscli"
include_recipe "devbox::instances"
include_recipe "devbox::users_groups"

execute "Restart apache" do
  command "service apache2 restart"
end