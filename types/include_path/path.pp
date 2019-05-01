# @summary
#   An include path can either a local file path or a UNC path.
#
type Lmhosts::Include_path::Path = Variant[
  Stdlib::Absolutepath,
  Lmhosts::UNC,
]
