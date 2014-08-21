default['devbox']['main_user']= [ 'ubuntu' ]
default['devbox']['main_users'] = [ 'systemstorage' ]
default['devbox']['main_groups'] = [ 'www-data', 'systemstorage' ]
default['devbox']['known_hosts'] = []
default['devbox']['magento_instances_databag_name'] = 'magento-sites'

default['devbox']['packagespurge'] = []
default['devbox']['packages'] = [ 'unzip', 'graphicsmagick', 'jq', 'tig' ]

include_attribute 'apache2'
default['apache']['default_site_enabled'] = false
default['apache']['version'] = '2.4'
normal['apache']['version'] = '2.4'
override['apache']['version'] = '2.4'

include_attribute 'mysql'
default['mysql']['server_debian_password'] = 'root'
default['mysql']['server_root_password'] = 'root'
default['mysql']['server_repl_password'] = 'root'

