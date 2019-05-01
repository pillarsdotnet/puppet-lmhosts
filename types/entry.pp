# @summary
#   An LMhosts entry may be a host, an include, or a list of alternates.
#
type Lmhosts::Entry = Variant[
  Lmhosts::Alternates::Resource,
  Lmhosts::Host::Resource,
  Lmhosts::Include_path::Resource,
]
