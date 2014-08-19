action :create do

  user 'systemstorage' do
    home '/home/systemstorage'
  end

  group 'systemstorage' do
    action :create
  end

  %w(database files).each do |name|
    directory "/home/systemstorage/systemstorage/#{new_resource.project}/backup/#{new_resource.environment}/#{name}" do
      owner 'systemstorage'
      group 'systemstorage'
      mode 00775
      recursive true
      action :create
    end
  end

  directory "/home/systemstorage/systemstorage/#{new_resource.project}/bin" do
    owner 'systemstorage'
    group 'systemstorage'
    mode 00775
    recursive true
    action :create
  end

  execute 'fix systemstorage permissions' do
    command 'chown -R systemstorage:systemstorage /home/systemstorage/systemstorage; chmod -R ug+rw /home/systemstorage/systemstorage'
    user 'root'
  end

end
