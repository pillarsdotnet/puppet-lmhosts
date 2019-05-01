# @summary
#   Ordered List of alternate file or UNC locations where Lmhosts fragments may be found.
#
type Lmhosts::Alternates::Resource = Struct[
  {
    alternates      => Array[Lmhosts::Include_path::Path],
    Optional[index] => Lmhosts::Order,
    Optional[path]  => Stdlib::Absolutepath,
  }
]
