Chef::Log.info("Writing motd");

execute "Remove all existing motd" do
  user 'root'
  command "chmod -x /etc/update-motd.d/*"
end

motd = ""

motd << '     __    __  .__   __.  __  .______     ______   ___   ___ ' + "\n"
motd << '    |  |  |  | |  \ |  | |  | |   _  \   /  __  \  \  \ /  / ' + "\n"
motd << '    |  |  |  | |   \|  | |  | |  |_)  | |  |  |  |  \  V  /  ' + "\n"
motd << '    |  |  |  | |  . `  | |  | |   _  <  |  |  |  |   >   <   ' + "\n"
motd << '    |  `--   | |  |\   | |  | |  |_)  | |  `--   |  /  .  \  ' + "\n"
motd << '     \______/  |__| \__| |__| |______/   \______/  /__/ \__\ ' + "\n"
motd << '    -------------------------------------------------------- ' + "\n"
motd << "\n"


sites = data_bag(node['devbox']['magento_instances_databag_name'])
sites.each do |site|
  opts = data_bag_item(node['devbox']['magento_instances_databag_name'], site)

  if opts.key?("motd")
    motd << "\n"
    opts["motd"].each do |line|
      motd << "#{line}\n"
    end
    motd << "\n"
  end

end

file '/etc/motd' do
  content motd
end