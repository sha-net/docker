 $packages = ['apt-transport-https', 'ca-certificates']
 package { $packages: ensure => 'installed' }
 $codename = $::lsbdistcodename
 $dockerurl="\"deb https://apt.dockerproject.org/repo/ ubuntu-${codename} main\""
 
 exec { 'download GPG key':
   command => '/usr/bin/curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -'
 }

 exec { 'add GPG key':
  command => "/usr/bin/add-apt-repository ${dockerurl}",
  unless  => "/bin/grep ^${dockerurl} /etc/apt/sources.list",
#  command => '/usr/bin/add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-xenial main"',
#  unless  => '/bin/grep ^"deb https://apt.dockerproject.org/repo/ ubuntu-xenial main" /etc/apt/sources.list',
 }

 exec { 'apt update':
  command => '/usr/bin/apt-get update',
 }
 
 package { 'docker-engine':
  ensure => 'installed',
  require  => Exec['apt update'],
 }
 
 package { 'python-pip':
  ensure => 'installed',
  require  => Exec['apt update'],
 }

 exec { 'install docker-compose':
  command => '/usr/bin/pip install docker-compose',
  unless => '/usr/bin/test -f /usr/local/bin/docker-compose',
 }
 
