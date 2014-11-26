# Definition steelapp::enable
#

define steelapp::enable(
    $pool,
    $node        = $title,
) {

  include steelapp

  exec { "enable-${pool}-${node}":
    command     => "/usr/local/sbin/steelapp.pl enable \"${pool}\" \"${node}\"",
    user        => 'root',
    require     => Class['steelapp'],
  }

}
