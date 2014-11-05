Chef::Log.info("Preparing Magento instances");

user 'systemstorage' do
  home '/home/systemstorage'
end

group 'systemstorage' do
  action :create
end

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

  Chef::Log.info("awscli: #{opts["awscli"]}")

  opts["awscli"].each do |profile, conf|
    conf.each do |key, value|
      execute "Configure aws cli tool for #{profile} and #{key}" do
        user node['devbox']['main_user']
        command "aws configure set #{key} '#{value}' --profile #{profile}"
        action :run
      end
    end
  end

end