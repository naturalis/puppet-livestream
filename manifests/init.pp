# == Class: livestream
#
# Author Name <foppe.pieters@naturalis.nl>
#
class livestream (
    $channel_id    = undef,
    $api_key       = undef,
){
  file { '/var/www/htdocs/index.php' :
    content     => template('livestream/index.php.erb'),
    mode        => '0755',
  }
  file { '/var/www/htdocs/EmbedYoutubeLiveStreaming.php' :
    content     => template('livestream/EmbedYoutubeLiveStreaming.php.erb'),
    mode        => '0755',
  }
}
