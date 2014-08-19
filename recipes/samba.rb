package "samba" do
  action :upgrade
end

execute "Create samba user for #{node[:devbox][:main_user]}" do
  command "echo '#{node[:devbox][:main_user]}\n#{node[:devbox][:main_user]}' | smbpasswd -s -a #{node[:devbox][:main_user]}"
end

template "Samba configuration" do
  source 'smb.conf.erb'
  mode 00644
  owner 'root'
  group 'root'
  cookbook 'devbox'
  action :create
  variables(
    valid_users: node[:devbox][:main_user]
  )
end
