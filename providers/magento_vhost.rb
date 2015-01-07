action :create do
  Chef::Log.info("Create Magento vhost and folders: #{new_resource.name}")

  %w(releases shared/var shared/media).each do |name|
    directory "/var/www/#{new_resource.project}/#{new_resource.environment}/#{name}" do
      owner 'www-data'
      group 'www-data'
      mode 00775
      recursive true
      action :create
    end
  end

  docroot = "/var/www/#{new_resource.project}/#{new_resource.environment}/releases/current/htdocs"
  server_name = new_resource.server_name
  server_aliases = new_resource.server_aliases

  template "/etc/apache2/sites-available/#{server_name}.conf" do
    source 'vhost.erb'
    mode 00644
    owner 'root'
    group 'root'
    cookbook 'devbox'
    action :create
    variables(
      docroot: docroot,
      server_name: server_name,
      server_aliases: server_aliases
    )
  end

  execute "Enable vhost #{server_name}" do
    command "a2ensite #{server_name}.conf && service apache2 restart"
  end

end