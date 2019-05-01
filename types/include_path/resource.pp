# @summary
#   An include contains either a local file path or a UNC path.
#
type Lmhosts::Include_path::Resource = Struct[
  {
    include_path    => Lmhosts::Include_path::Path,
    Optional[index] => Lmhosts::Order,
    Optional[path]  => Stdlib::Absolutepath,
  }
]
