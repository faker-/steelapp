# Definition steelapp::drain
#

define steelapp::drain(
    $pool,
    $node        = $title,
) {

  include steelapp

  exec { "drain-${pool}-${node}":
    command     => "/usr/local/sbin/steelapp.pl drain \"${pool}\" \"${node}\"",
    user        => 'root',
    require     => Class['steelapp'],
  }

}
