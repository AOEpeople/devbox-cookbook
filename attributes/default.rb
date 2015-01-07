default['devbox']['main_user'] = 'ubuntu'
default['devbox']['main_users'] = [ 'systemstorage' ]
default['devbox']['main_groups'] = [ 'www-data', 'systemstorage' ]
default['devbox']['known_hosts'] = []
default['devbox']['magento_instances_databag_name'] = 'magento-sites'

default['devbox']['packages'] = [
   'unzip', 'graphicsmagick', 'jq', 'tig', 'git',
   'apache2',
   'mysql-server-5.6', 'mysql-client-5.6',
   'php5', 'php5-curl', 'php5-gd', 'php5-mcrypt', 'php5-redis', 'php5-mhash', 'php5-cli', 'php5-mysql', 'php5-gd', 'php5-intl', 'php5-common'
]

default['devbox']['apache_modules'] = [ 'headers', 'rewrite' ]
default['devbox']['php5_modules'] = [ 'mcrypt' ]