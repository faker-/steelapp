# == Class: steelapp
#
# Installs dependency packages and files to allow accessing the Riverbed
# SteelApp SOAP API.
# Will be included by the defined types.
#
# === Authors
#
# Roman Mueller
#
# === Copyright
#
# Copyright 2014 Roman Mueller, unless otherwise noted.
#
class steelapp (
    $username = 'admin',
    $password = 'admin',
    $server   = 'localhost',
    $port     = '9090',
) {

  $dependency_pkgs =  [ 'perl-SOAP-Lite',
                        'perl-Crypt-SSLeay',
                        'perl-libwww-perl',
                      ]

  package { $dependency_pkgs:
    ensure => installed,
  }

  file { '/usr/local/sbin/steelapp.pl':
    ensure  => file,
    content => template("${module_name}/steelapp.pl.rb"),
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    require => Package[$dependency_pkgs],
  }

}
