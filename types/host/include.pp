# @summary
#   One more more files or UNC paths.
#
type Lmhosts::Include = Variant[
  Lmhosts::Filesource,
  Array[Lmhosts::Filesource,2]
]