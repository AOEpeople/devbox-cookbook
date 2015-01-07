action :create do

     name = new_resource.name
     password = new_resource.password || new_resource.name

     execute "Create database user #{name}" do
       command "mysql -u root -e 'CREATE USER \\'#{name}\\'@\\'localhost\\' IDENTIFIED BY \\'#{password}\\';'"
     end

     execute "Grant usage to #{name}" do
       command "mysql -u root -e 'GRANT USAGE ON *.* TO \\'#{name}\\'@\\'localhost\\' IDENTIFIED BY \\'#{password}\\' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;'"
     end

     execute "Create database #{name}" do
       command "mysql -u root -e 'CREATE DATABASE IF NOT EXISTS #{name};'"
     end

     execute "Grant privileges #{name}" do
       command "mysql -u root -e 'GRANT ALL PRIVILEGES ON \\'#{name}\\'.* TO '#{name}'@'localhost';'"
     end

     execute "Flush privileges" do
       command "mysql -u root -e 'FLUSH PRIVILEGES;'"
     end

   end