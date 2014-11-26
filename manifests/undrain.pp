# Definition steelapp::undrain
#

define steelapp::undrain(
    $pool,
    $node        = $title,
) {

  include steelapp

  exec { "undrain-${pool}-${node}":
    command     => "/usr/local/sbin/steelapp.pl undrain \"${pool}\" \"${node}\"",
    user        => 'root',
    require     => Class['steelapp'],
  }

}
