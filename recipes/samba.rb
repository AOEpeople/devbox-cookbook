include_recipe "samba::server"
node.samba.workgroup = "WORKGROUP"
node.samba.interfaces = ""
node.samba.hosts_allow = ""

samba_user node[:devbox][:main_user] do
  password node[:devbox][:main_user] 
  action [:create, :enable]
end
