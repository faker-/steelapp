# steelapp

#### Table of Contents

1. [Overview](#overview)
2. [Usage](#usage)
3. [Limitations](#limitations)

## Overview

Adds the possibility to drain, undrain, disable and enable nodes on Riverbed
SteelApp Traffic Managers using their SOAP API.

## Usage

- Create a new user on the SteelApp management interface with appopariate rights to drain/undrain/disable/enable.
- Add the credentails to your Hiera configuration where it fits best (node level or environment):

        steelapp::username : 'drainuser'
        steelapp::password : 'complexpassword'
        steelapp::server   : 'steelapp1.int.example.com'

You can also specify `steelapp::port` (defaults to `9090`).

- You can now drain a node by calling:

        steelapp::drain {'www01.int.example.com:80':
          pool => 'My WebApp',
        }

Note that the node must include the port!
Both the node and pool name must be exactly specified like they appear in the SteelApp management interface.
It is also possible to use it like this:

    steelapp::drain {"${::fqdn}:443":
      pool => 'My WebApp',
    }

But this requires that the FQDN is configured in the SteelApp and not a CNAME or IP address.

Using the same parameters you can use `steelapp::undrain`, `steelapp::disable` and `steelapp::enable`.

It is not adviced to call this directly in your normal Puppet manifests.
Rather it should be used in something like: 
https://github.com/ripienaar/puppet-mcollective/tree/master/example/web_deploy
Where it can be used to replace `haproxy::disable` and `haproxy::enable` from the example code.

## Limitations

This class may be very specific to our environment.
We make heavy use of Hiera and we only use Puppet >=3.7 on CentOS >=6.6 servers.

If you try to take an invalid action on a node (e.g. drain a already drained node),
it will currently bail out with an error.

