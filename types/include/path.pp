# @summary
#   An include path can either a local file path or a UNC path.
#
type Lmhosts::Include::Path = Variant[
  Stdlib::Absolutepath,
  Lmhosts::UNC,
]
