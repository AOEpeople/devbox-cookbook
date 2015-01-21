action :create do

  name = new_resource.name
  password = new_resource.password || new_resource.name

  execute "Create user and grant usage to #{name}" do
    command "mysql -u root -e \"GRANT ALL ON *.* TO '#{name}'@'localhost' IDENTIFIED BY '#{password}';\""
  end

  execute "Create database #{name}" do
    command "mysql -u root -e \"CREATE DATABASE IF NOT EXISTS #{name};\""
  end

  execute "Grant privileges #{name}" do
    command "mysql -u root -e \"GRANT ALL PRIVILEGES ON #{name}.* TO '#{name}'@'localhost';\""
  end

  execute "Flush privileges for #{name}" do
    command "mysql -u root -e \"FLUSH PRIVILEGES;\""
  end

end