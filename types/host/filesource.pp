# @summary
#   A local or remote file path.
#
type Lmhosts::Filesource = Variant[
  Stdlib::Absolutepath,
  Lmhosts::UNC,
]
