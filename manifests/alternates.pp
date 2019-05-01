# @summary Adds an alternates block to the lmhosts file.
#
# Samba will attempt to load each alternate file in turn, stopping at the first
# available and ignoring the rest.
#
# @example
#   lmhosts::alternates { '/etc/lmhosts 1234':
#     alternates => [
#       '//pdc/share/lmhosts',
#       '//bdc/share/lmhosts',
#     ]
#   }
#
# @param [Array[Lmhosts::Include_path::Path]] alternates
#   The list of local or UNC file paths to load.
#
# @param [Lmhosts::Order] index
#   Used by stdlib::concat to assemble lmhosts fragments in the correct order.
#
# @param [Stdlib::Absolutepath] path
#   The file path of the lmhosts file being managed.
#
define lmhosts::alternates (
  Array[Lmhosts::Include_path::Path] $alternates,
  Lmhosts::Order                     $index = regsubst($title, /\A(.+)[ ]([0-9.]+)\z/,'\\2'),
  Stdlib::Absolutepath               $path  = regsubst($title, /\A(.+)[ ]([0-9.]+)\z/,'\\1'),
) {
  $order = $index ? {
    Integer => String($index, '%04d'),
    default => $index,
  }
  concat::fragment { "lmhosts::alternate::begin ${title}":
    content => "#BEGIN_ALTERNATE\r\n",
    order   => "${order}.0000",
    target  => $path,
  }
  $alternates.each |Integer[1] $subindex, Lmhosts::Inc::Path $inc| {
    $suborder = String($subindex, '%04d')
    $subtitle = "${path} ${order}.${suborder}"
    create_resources('lmhosts::inc', { $subtitle => { 'inc' => $inc } })
  }
  concat::fragment { "lmhosts::alternate::end ${title}":
    content => "#END_ALTERNATE\r\n",
    order   => "${order}.9999",
    target  => $path,
  }
}
