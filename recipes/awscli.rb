package 'unzip' do
  action :upgrade
end

remote_file "#{Chef::Config[:file_cache_path]}/awscli-bundle.zip" do
  source 'https://s3.amazonaws.com/aws-cli/awscli-bundle.zip'
  not_if 'test -e /usr/local/bin/aws'
  notifies :run, 'execute[install awscli]', :immediately
end

execute 'install awscli' do
  command 'unzip awscli-bundle.zip; ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws'
  user 'root'
  cwd Chef::Config[:file_cache_path]
  action :nothing
end


sites = data_bag(node['devbox']['magento_instances_databag_name'])
sites.each do |site|
  opts = data_bag_item(node['devbox']['magento_instances_databag_name'], site)

  # awscli configuration
  if opts.key?("awscli")
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

end