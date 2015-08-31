Chef::Log.info("Writing hosts file");

ip=`ifconfig eth1 | grep "inet " | awk -F'[: ]+' '{ print $4 }'`.strip
ip_host=`netstat -rn | grep "^0.0.0.0 " | cut -d " " -f10`.strip

local_hostsfile  = "# This file is managed by the devbox cookbook\n"
local_hostsfile << "# Don't edit manually\n"
local_hostsfile << "127.0.0.1    localhost\n"
local_hostsfile << "#{ip_host}    vmhost\n"

hosts_hostsfile = "# This snippet is managed by the devbox cookbook\n"
hosts_hostsfile << "# Please insert it into your host system's host file\n"
hosts_hostsfile << "#{ip}     unibox\n"

sites = data_bag(node['devbox']['magento_instances_databag_name'])
sites.each do |site|
  opts = data_bag_item(node['devbox']['magento_instances_databag_name'], site)

  # hosts files
  local_hostsfile << "127.0.0.1    #{opts["server_name"]}"
  hosts_hostsfile << "#{ip}    #{opts["server_name"]}"
  if opts.key?("server_aliases")
    opts["server_aliases"].each do |h|
      local_hostsfile << " #{h}"
      hosts_hostsfile << " #{h}"
    end
  end
  local_hostsfile << "\n"
  hosts_hostsfile << "\n"

end

file '/etc/hosts' do
  content local_hostsfile
end

file '/var/www/hosts.hosts' do
  content hosts_hostsfile
end
