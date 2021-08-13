# ukemi

[![Gem Version](https://badge.fury.io/rb/ukemi.svg)](https://badge.fury.io/rb/ukemi)
[![Ruby CI](https://github.com/ninoseki/ukemi/actions/workflows/test.yaml/badge.svg)](https://github.com/ninoseki/ukemi/actions/workflows/test.yaml)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/ukemi/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/ukemi?branch=master)
[![CodeFactor](https://www.codefactor.io/repository/github/ninoseki/ukemi/badge)](https://www.codefactor.io/repository/github/ninoseki/ukemi)

Ukemi is a CIL tool for querying passive DNS services.

It supports the following services.

- [CIRCL passive DNS](https://www.circl.lu/services/passive-dns/)
- [DNSDB](https://api.dnsdb.info/)
- [OTX](https://otx.alienvault.com)
- [PassiveTotal](https://community.riskiq.com/)
- [SecurityTrails](https://securitytrails.com/)
- [VirusTotal](http://virustotal.com)

It outputs passive DNS resolutions as JSON.

## Requirements

- Ruby 2.7+ or Ruby 3.x

## Installation

```bash
gem install ukemi
```

## Configuration

Configuration is done via environment variables.

| Key                    | Desc.                      |
|------------------------|----------------------------|
| CIRCL_PASSIVE_PASSWORD | CIRCL passive DNS password |
| CIRCL_PASSIVE_USERNAME | CIRCL passive DNS username |
| DNSDB_API_KEY          | DNSDB API key              |
| OTX_API_KEY            | OTX API key                |
| PASSIVETOTAL_API_KEY   | PassiveTotal API key       |
| PASSIVETOTAL_USERNAME  | PassiveTotal username      |
| SECURITYTRAILS_API_KEY | SecurityTrails API key     |
| VIRUSTOTAL_API_KEY     | VirusTotal API key         |

## Usage

```bash
$ ukemi
Commands:
  ukemi help [COMMAND]      # Describe available commands or one specific command
  ukemi lookup [IP|DOMAIN]  # Lookup passive DNS services

$ ukemi help lookup
Usage:
  ukemi lookup [IP|DOMAIN]

Options:
  [--order-by=ORDER_BY]  # Ordering of the passve DNS resolutions (last_seen or first_seen)
                         # Default: -last_seen

Lookup passive DNS servicess
```

```bash
$ ukemi lookup example.com
{
  "93.184.216.34": {
    "first_seen": "2016-03-01",
    "last_seen": "2020-03-16",
    "sources": [
      {
        "first_seen": "2016-10-07",
        "last_seen": "2018-10-30",
        "source": "CIRCL"
      },
      {
        "first_seen": "2016-03-01",
        "last_seen": "2020-03-16",
        "source": "SecurityTrails"
      },
      {
        "first_seen": "2020-03-03",
        "last_seen": "2020-03-03",
        "source": "VirusTotal"
      }
    ]
  },
  ...
}

$ ukemi lookup 195.123.226.243
{
  "example.org": {
    "first_seen": "2011-04-11",
    "last_seen": "2020-03-16",
    "sources": [
      {
        "first_seen": "2011-04-11",
        "last_seen": "2011-04-11",
        "source": "CIRCL"
      },
      {
        "first_seen": "2016-10-09",
        "last_seen": "2018-10-28",
        "source": "CIRCL"
      },
      {
        "first_seen": "2014-12-09",
        "last_seen": "2020-03-16",
        "source": "PassiveTotal"
      },
      {
        "first_seen": null,
        "last_seen": null,
        "source": "SecurityTrails"
      }
    ]
  },
  ...
}

# or you scan skip "lookup"
$ ukemi example.com
$ ukemi 195.123.226.243

# You can specify the order of resolutions

# Order by last_seen DESC
$ ukemi lookup example.com --order-by -last_seen

# Order by last_seen ASC
$ ukemi lookup example.com --order-by last_seen

# Order by first_seen DESC
$ ukemi lookup example.com --order-by -first_seen

# Order by first_seen ASC
$ ukemi lookup example.com --order-by first_seen
```

### Using with jq

[jq](https://stedolan.github.io/jq/)'s powerful processor helps to interact with the output.

```bash
# List up resolutions only
$ ukemi lookup example.com | jq "keys"
[
  "192.0.32.10",
  "192.0.43.10",
  "208.77.188.166",
  "209.67.208.202",
  "221.121.159.162",
  "93.184.216.119",
  "93.184.216.34"
]

# List up the first 2 objects
$ ukemi lookup example.com  | jq "to_entries | .[:2] | from_entries"
{
  "93.184.216.34": {
    "first_seen": "2016-03-01",
    "last_seen": "2020-03-16",
    "sources": [
      {
        "first_seen": "2016-10-07",
        "last_seen": "2018-10-30",
        "source": "CIRCL"
      },
      {
        "first_seen": "2016-03-01",
        "last_seen": "2020-03-16",
        "source": "SecurityTrails"
      },
      {
        "first_seen": "2020-03-03",
        "last_seen": "2020-03-03",
        "source": "VirusTotal"
      }
    ]
  },
  "221.121.159.162": {
    "first_seen": "2019-11-04",
    "last_seen": "2019-11-04",
    "sources": [
      {
        "first_seen": "2019-11-04",
        "last_seen": "2019-11-04",
        "source": "VirusTotal"
      }
    ]
  }
}
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
