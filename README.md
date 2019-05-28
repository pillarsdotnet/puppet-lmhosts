# lmhosts

## Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with lmhosts](#setup)
    * [Dependencies](#dependencies)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

This module manages the [`lmhosts`](http://bit.ly/2L2zaY) file.

The `lmhosts` file allows certain information about your Windows network to be
pre-loaded without performing any network lookups.

## Setup

For use with [`r10k`](https://puppet.com/docs/pe/latest/r10k.html) or
[`g10k`](https://github.com/xorpaul/g10k), add an entry to your
[`Puppetfile`](https://puppet.com/docs/pe/latest/puppetfile.html) as follows:

```puppetfile
mod lmhosts,
  :git -> 'https://github.com/pillarsdotnet/lmhosts'
```

For use with another module, add a dependency to its
[`metadata.json`](https://puppet.com/docs/puppet/latest/modules_metadata.html)
file:

```json
  "dependencies": [
    {
      "name"               : "pillarsdotnet/lmhosts",
      "version_requirement": ">= 0.0.1 < 1.0.0"
    },
  ]
```

### Dependencies

For Windows clients, the
[`puppet/windows_env`](https://github.com/voxpupuli/puppet-windows_env)
module is required. Non-windows clients may ignore this dependency.

## Usage

### Generate a standard lmhosts file

This will create an lmhosts file containing an entry for `localhost`, plus one
host entry for each node in the catalog.

```puppet
include ::lmhosts
```

### Add static entries for localhost and CORP-PDC

#### hieradata

```yaml
lmhosts::list:
  - address: '127.0.0.1'
    host:    'localhost'
  - address: '10.0.0.100'
    host:    'corp-pdc'
```

#### puppet

```puppet
include ::lmhosts
```

## Reference

See [`REFERENCE.md`](https://github.com/pillarsdotnet/puppet-lmhosts/blob/master/REFERENCE.md).

## Development

Submit bug-reports, issues, and pull-requests to
[https://github.com/pillarsdotnet/puppet-lmhosts](https://github.com/pillarsdotnet/puppet-lmhosts]).

## Changelog

See [`CHANGELOG.md`](https://github.com/pillarsdotnet/puppet-lmhosts/blob/master/CHANGELOG.md).
