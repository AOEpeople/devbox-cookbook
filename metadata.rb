name             'devbox'
maintainer       'Fabrizio Branca'
maintainer_email 'mail@<firstname>-<lastname>.de'
license          'All rights reserved'
description      'Installs/Configures devbox'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.0'

depends 'ssh_known_hosts'
# depends 'cron'

supports 'ubuntu'
