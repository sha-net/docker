File { backup => false }

node default {
  file { '/tmp/puppet-in-docker':
    ensure  => present,
    content => 'This file is for demonstration purposes only',
  }
}

node 'puppetondocker-shavit.ec2.internal' {
 $a = hiera('test')
 notify { "$a": }
}
