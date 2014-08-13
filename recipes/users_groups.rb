
node.default['devbox']['main_users'] << node['devbox']['main_user']

# put all users in node['devbox']['main_groups'] to all groups in node['devbox']['main_groups']
node['devbox']['main_groups'].each do |group_name|
  group group_name do
    action :modify
    members node['devbox']['main_users']
    append true
  end
end