# @summary Add an #INCLUDE line to the lmhosts file.
#
# If the order and path are unspecified, the title must
# consist of a filepath followed by a space and a valid
# order string.
#
# @example
#   lmhosts::include { '/etc/lmhosts 1234':
#     include => '//pdc/share/lmhosts',
#   }
#
# @param [Lmhosts::Include::Path] include
#   Local path or UNC of the lmhosts fragment to include.
#
# @param [Lmhosts::Order] index
#   Used by stdlib::concat to assemble lmhosts fragments in the correct order.
#
# @param [Stdlib::Absolutepath] path
#   The file path of the lmhosts file being managed.
#
define lmhosts::include (
  Lmhosts::Include::Path $include,
  Lmhosts::Order         $index = $title.regsubst(/\A(.+)[ ]([0-9.]+)\z/,'\\2'),
  Stdlib::Absolutepath   $path  = $title.regsubst(/\A(.+)[ ]([0-9.]+)\z/,'\\1'),
) {
  $order = $index ? {
    Integer => String($index, '%04d'),
    default => $index,
  }
  concat::fragment { "lmhosts::include ${title}":
    content => "#INCLUDE ${include}\r\n",
    order   => $order,
    target  => $path,
  }
}
