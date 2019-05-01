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
  Lmhosts::List        $list      = [
    {
      'address' => '127.0.0.1',
      'host'    => 'localhost'
    }
  ],
  Boolean              $no_export = false,
  Boolean              $no_import = false,
  Stdlib::Absolutepath $path      = $facts['kernel'] ? {
    'windows' => "${facts['windows_env']['SYSTEMROOT']}\\System32\\drivers\\etc\\lmhosts",
    default   => '/etc/samba/lmhosts',
  }
){
  # Create the lmhosts file.
  concat { $path:
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
    create_resources($type, { "${path} ${order}" => $entry })
  }

  # Export the current host.
  unless $no_export {
    $hostname = $facts['networking']['hostname']
    @@lmhosts::host { "${path} ${hostname} (exported)":
      address => $facts['networking']['ip'],
      host    => $hostname,
      index   => 'catalog',
      path    => $path,
      preload => true,
    }
  }

  # Collect all exported hosts.
  unless $no_import {
    Lmhosts::Host <<| |>>
  }
}
