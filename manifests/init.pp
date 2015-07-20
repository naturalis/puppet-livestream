# == Class: livestream
#
# Author Name <foppe.pieters@naturalis.nl>
#
class livestream (
    $channel_id    = undef,
    $api_key       = undef,
){
  # install packages
  package { 'p7zip-full':
    ensure                => installed
  }
  file { '/var/www/htdocs/index.php' :
    content     => template('livestream/index.php.erb'),
    mode        => '0755',
  }
  # download protected images
  file {'/tmp/test-stream.zip':
    ensure                => 'present',
    source                => 'puppet:///modules/livestream/test-stream.zip',
    mode                  => '0755',
    owner                 => 'kiosk',
    group                 => 'kiosk',
    notify                => Exec['site-unzip']
  }

  exec {'site-unzip':
    command               => '/usr/bin/7z x -aoa /tmp/test-stream.zip',
    cwd                   => '/var/www/htdocs/',
    unless                => '/usr/bin/test -f /var/www/htdocs/css',
    refreshonly           => true,
    require               => File['/tmp/test-stream.zip'],
  }
}
