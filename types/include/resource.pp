# @summary
#   An include contains either a local file path or a UNC path.
#
type Lmhosts::Include::Resource = Struct[
  {
    include         => Lmhosts::Include::Path,
    Optional[index] => Lmhosts::Order,
    Optional[path]  => Stdlib::Absolutepath,
  }
]
