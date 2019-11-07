# @summary Manage the /etc/samba/lmhosts file.
#
# This class manages entries within the Samba lmhosts file, based on documentation
# found at http://bit.ly/2L2zaYJ
#
# @example
#   class { 'lmhosts' :
#     list => [
#       {
#         'address' => '127.0.0.1',
#         'host'    => 'localhost',
#       },
#       { 'address' => '192.168.1.100',
#         'host'    => 'pdc',
#       }
#     ],
#
# @param [Lmhosts::List] list
#   Ordered List of lmhosts entries.
#
# @param [Boolean] no_export
#   If true, do not export the current host for use by other nodes.
#
# @param [Boolean] no_import
#   If true, do not add exported host entries to this node's lmhosts file.
#
# @param [Stdlib::Absolutepath] path
#   Absolute path to the lmhosts file to manage.
#
class lmhosts(
  Lmhosts::List        $list,
  Boolean              $no_export,
  Boolean              $no_import,
  Stdlib::Absolutepath $path,
){
  # Downcase windows paths.
  $winpath = $facts['kernel'] ? {
    'windows' => $path.downcase,
    default   => $path
  }

  # Create the lmhosts file.
  concat { $winpath:
    ensure => 'present',
  }

  # Add static hosts not in the catalog.
  $list.each |Integer[0,9999] $index, Lmhosts::Entry $entry| {
    $type = $entry ? {
      Lmhosts::Alternates::Resource => 'lmhosts::alternates',
      Lmhosts::Host::Resource       => 'lmhosts::host',
      Lmhosts::Include::Resource    => 'lmhosts::include',
    }
    $order = String($index, '%04d')
    create_resources($type, { "${winpath} ${order}" => $entry })
  }

  # Export the current host.
  unless $no_export {
    $host = $facts['networking']['hostname']
    $addr = $facts['networking']['ip']
    @@lmhosts::host { "${winpath} ${host} ${addr}":
      address => $addr,
      host    => $host,
      index   => 'catalog',
      path    => $winpath,
      preload => true,
    }
  }

  # Collect all exported hosts.
  unless $no_import {
    Lmhosts::Host <<| |>>
  }
}
