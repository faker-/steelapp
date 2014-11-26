# Definition steelapp::disable
#

define steelapp::disable(
    $pool,
    $node        = $title,
) {

  include steelapp

  exec { "disable-${pool}-${node}":
    command     => "/usr/local/sbin/steelapp.pl disable \"${pool}\" \"${node}\"",
    user        => 'root',
    require     => Class['steelapp'],
  }

}
