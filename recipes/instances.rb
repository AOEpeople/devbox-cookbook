Chef::Log.info("Preparing Magento instances");

user 'systemstorage' do
  home '/home/systemstorage'
end

group 'systemstorage' do
  action :create
end

ip=`ifconfig eth1 | grep "inet " | awk -F'[: ]+' '{ print $4 }'`.strip

sites = data_bag(node['devbox']['magento_instances_databag_name'])
sites.each do |site|
  opts = data_bag_item(node['devbox']['magento_instances_databag_name'], site)

  Chef::Log.info("Found Magento site #{opts["id"]}")

  # Create vhost
  devbox_magento_vhost "#{opts["project"]}_#{opts["environment"]}" do
    project opts["project"]
    environment opts["environment"]
    server_name opts["server_name"]
    server_aliases opts["server_aliases"]
  end

  # create local system storage directories
  if opts.key?("prepare_systemstorages")
    opts["prepare_systemstorages"].each do |name|
      devbox_systemstorage "#{opts["project"]}_#{name}" do
        project opts["project"]
        environment name
      end
    end
  end

  # databases
  if opts.key?("databases")
    opts["databases"].each do |dbname|
      devbox_magento_db dbname
    end
  end
  
  # Fetch the deploy scripts
  if opts.key?("deploy_scripts")
    directory "/home/systemstorage/systemstorage/#{opts["project"]}/bin" do
      owner 'systemstorage'
      group 'systemstorage'
      mode 00775
      recursive true
      action :create
    end

    execute "Get deploy scripts for #{opts["project"]}" do
      command "if [ ! -d /home/systemstorage/systemstorage/#{opts["project"]}/bin/deploy ] ; then git clone #{opts["deploy_scripts"]} /home/systemstorage/systemstorage/#{opts["project"]}/bin/deploy ; fi"
      user "systemstorage"
    end
  end
end
