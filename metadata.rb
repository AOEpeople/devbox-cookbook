name             'devbox'
maintainer       'Fabrizio Branca'
maintainer_email 'mail@<firstname>-<lastname>.de'
license          'All rights reserved'
description      'Installs/Configures devbox'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends 'apache2'
depends 'mysql'
depends 'database'
depends 'php'
depends 'ssh_known_hosts'
depends 'samba'
# depends 'cron'

supports 'ubuntu'
