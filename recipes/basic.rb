node['devbox']['packagespurge'].each do |pkg|
  package pkg do
    action :remove
  end
end

node['devbox']['packages'].each do |pkg|
  package pkg do
    action :upgrade
  end
end

node['devbox']['known_hosts'].each do |known_host|
  ssh_known_hosts_entry known_host
end