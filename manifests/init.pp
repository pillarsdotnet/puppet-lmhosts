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
# @param [Boolean] export
#   If true (default), export the current host for use by other nodes.
#
# @param [Boolean] import
#   If true (default), add all exported host entries to this node's lmhosts file.
#
# @param [Lmhosts::List] list
#   Ordered List of lmhosts entries.
#
# @param [Stdlib::Absolutepath] path
#   Absolute path to the lmhosts file to manage.
#
class lmhosts(
  Boolean              $export = true,
  Boolean              $import = true,
  Lmhosts::List        $list   = [],
  Stdlib::Absolutepath $path   = '/etc/hosts',
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
  if $export {
    @@lmhosts::host { "${path} ${facts.networking['hostname']} (exported)":
      address => $facts.networking.ip,
      host    => $facts.networking.hostname,
      index   => 'catalog',
      path    => $path,
      preload => true,
    }
  }

  # Collect all exported hosts.
  if $import {
    Lmhosts::Host <<| |>>
  }
}
