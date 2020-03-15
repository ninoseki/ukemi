# ukemi

[![Gem Version](https://badge.fury.io/rb/ukemi.svg)](https://badge.fury.io/rb/ukemi)
[![Build Status](https://travis-ci.com/ninoseki/ukemi.svg?branch=master)](https://travis-ci.com/ninoseki/ukemi)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/ukemi/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/ukemi?branch=master)
[![CodeFactor](https://www.codefactor.io/repository/github/ninoseki/ukemi/badge)](https://www.codefactor.io/repository/github/ninoseki/ukemi)

Ukemi is a CIL tool for querying passive DNS services.

It supports the following services.

- [CIRCL passive DNS](https://www.circl.lu/services/passive-dns/)
- [PassiveTotal](https://community.riskiq.com/)
- [SecurityTrails](https://securitytrails.com/)
- [VirusTotal](http://virustotal.com)

It outputs passive DNS resolutions as JSON.

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

$ ukemi help looup
Usage:
  ukemi lookup [IP|DOMAIN]

Lookup passive DNS services
```

```bash
$ ukemi lookup circl.lu
{
  "149.13.33.14": [
    {
      "firtst_seen": "2016-10-07",
      "last_seen": "2018-10-26",
      "source": "CIRCL"
    },
    {
      "firtst_seen": "2017-05-26",
      "last_seen": "2020-03-15",
      "source": "SecurityTrails"
    },
    {
      "firtst_seen": "2019-12-04",
      "last_seen": "2019-12-04",
      "source": "VirusTotal"
    }
  ],
  "149.13.33.4": [
    {
      "firtst_seen": "2011-03-08",
      "last_seen": "2012-02-13",
      "source": "CIRCL"
    },
    {
      "firtst_seen": "2013-07-30",
      "last_seen": "2013-07-30",
      "source": "VirusTotal"
    }
  ],
  "194.154.205.24": [
    {
      "firtst_seen": "2011-03-03",
      "last_seen": "2011-03-03",
      "source": "CIRCL"
    }
  ]
}

$ ukemi lookup 195.123.226.243
{
  "liankt.club": [
    {
      "firtst_seen": "2020-02-15",
      "last_seen": "2020-03-13",
      "source": "PassiveTotal"
    },
    {
      "firtst_seen": "2020-02-16",
      "last_seen": "2020-02-16",
      "source": "VirusTotal"
    }
  ],
  "weidt.club": [
    {
      "firtst_seen": "2020-03-12",
      "last_seen": "2020-03-12",
      "source": "PassiveTotal"
    }
  ],
  "jikt.club": [
    {
      "firtst_seen": "2020-03-04",
      "last_seen": "2020-03-12",
      "source": "PassiveTotal"
    },
    {
      "firtst_seen": "2020-03-05",
      "last_seen": "2020-03-05",
      "source": "VirusTotal"
    }
  ],
  "biesi.club": [
    {
      "firtst_seen": "2020-02-15",
      "last_seen": "2020-03-12",
      "source": "PassiveTotal"
    },
    {
      "firtst_seen": "2020-02-20",
      "last_seen": "2020-02-20",
      "source": "VirusTotal"
    }
  ],
  "kaikt.club": [
    {
      "firtst_seen": "2020-02-15",
      "last_seen": "2020-03-12",
      "source": "PassiveTotal"
    },
    {
      "firtst_seen": "2020-02-21",
      "last_seen": "2020-02-21",
      "source": "VirusTotal"
    }
  ],
  "zhaokt.club": [
    {
      "firtst_seen": "2020-02-15",
      "last_seen": "2020-03-11",
      "source": "PassiveTotal"
    },
    {
      "firtst_seen": "2020-02-18",
      "last_seen": "2020-02-18",
      "source": "VirusTotal"
    }
  ],
  "yangdt.club": [
    {
      "firtst_seen": "2020-02-26",
      "last_seen": "2020-03-10",
      "source": "PassiveTotal"
    },
    {
      "firtst_seen": "2020-02-27",
      "last_seen": "2020-02-27",
      "source": "VirusTotal"
    }
  ],
  "jinkt.club": [
    {
      "firtst_seen": "2020-02-21",
      "last_seen": "2020-03-10",
      "source": "PassiveTotal"
    },
    {
      "firtst_seen": "2020-02-22",
      "last_seen": "2020-02-22",
      "source": "VirusTotal"
    }
  ],
  "taokt.club": [
    {
      "firtst_seen": "2020-03-10",
      "last_seen": "2020-03-10",
      "source": "PassiveTotal"
    }
  ],
  "xinkt.club": [
    {
      "firtst_seen": "2020-02-17",
      "last_seen": "2020-03-09",
      "source": "PassiveTotal"
    },
    {
      "firtst_seen": "2020-02-19",
      "last_seen": "2020-02-19",
      "source": "VirusTotal"
    }
  ],
  "mail.realty-advertising.ru": [
    {
      "firtst_seen": "2019-11-08",
      "last_seen": "2020-03-09",
      "source": "PassiveTotal"
    }
  ],
  "realty-advertising.ru": [
    {
      "firtst_seen": "2019-11-08",
      "last_seen": "2020-03-06",
      "source": "PassiveTotal"
    }
  ],
  "ns1.realty-advertising.ru": [
    {
      "firtst_seen": "2019-12-02",
      "last_seen": "2020-03-04",
      "source": "PassiveTotal"
    }
  ],
  "ns2.realty-advertising.ru": [
    {
      "firtst_seen": "2019-12-04",
      "last_seen": "2020-03-04",
      "source": "PassiveTotal"
    }
  ],
  "xiankt.club": [
    {
      "firtst_seen": "2020-02-15",
      "last_seen": "2020-03-03",
      "source": "PassiveTotal"
    },
    {
      "firtst_seen": "2020-02-16",
      "last_seen": "2020-02-16",
      "source": "VirusTotal"
    }
  ],
  "nittsu-si.com": [
    {
      "firtst_seen": "2020-02-15",
      "last_seen": "2020-03-03",
      "source": "PassiveTotal"
    },
    {
      "firtst_seen": "2020-02-21",
      "last_seen": "2020-02-21",
      "source": "VirusTotal"
    }
  ],
  "mailer.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-23",
      "last_seen": "2020-02-23",
      "source": "PassiveTotal"
    }
  ],
  "mail7.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-23",
      "last_seen": "2020-02-23",
      "source": "PassiveTotal"
    }
  ],
  "zimbra.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-23",
      "last_seen": "2020-02-23",
      "source": "PassiveTotal"
    }
  ],
  "relay2.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-23",
      "last_seen": "2020-02-23",
      "source": "PassiveTotal"
    }
  ],
  "sniper.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-22",
      "last_seen": "2020-02-22",
      "source": "PassiveTotal"
    }
  ],
  "mailx.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-22",
      "last_seen": "2020-02-22",
      "source": "PassiveTotal"
    }
  ],
  "send.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-22",
      "last_seen": "2020-02-22",
      "source": "PassiveTotal"
    }
  ],
  "mta.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-22",
      "last_seen": "2020-02-22",
      "source": "PassiveTotal"
    }
  ],
  "home.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-22",
      "last_seen": "2020-02-22",
      "source": "PassiveTotal"
    }
  ],
  "pbrand.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-22",
      "last_seen": "2020-02-22",
      "source": "PassiveTotal"
    }
  ],
  "smtpauth.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-22",
      "last_seen": "2020-02-22",
      "source": "PassiveTotal"
    }
  ],
  "gate.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-21",
      "last_seen": "2020-02-21",
      "source": "PassiveTotal"
    }
  ],
  "mx02.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-21",
      "last_seen": "2020-02-21",
      "source": "PassiveTotal"
    }
  ],
  "outmail.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-21",
      "last_seen": "2020-02-21",
      "source": "PassiveTotal"
    }
  ],
  "exchange.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-21",
      "last_seen": "2020-02-21",
      "source": "PassiveTotal"
    }
  ],
  "ms.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-21",
      "last_seen": "2020-02-21",
      "source": "PassiveTotal"
    }
  ],
  "owa.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-20",
      "last_seen": "2020-02-20",
      "source": "PassiveTotal"
    }
  ],
  "mail8.realty-advertising.ru": [
    {
      "firtst_seen": "2020-02-20",
      "last_seen": "2020-02-20",
      "source": "PassiveTotal"
    }
  ],
  "mta-sts.realty-advertising.ru": [
    {
      "firtst_seen": "2019-11-11",
      "last_seen": "2020-02-08",
      "source": "PassiveTotal"
    }
  ],
  "mail02.realty-advertising.ru": [
    {
      "firtst_seen": "2020-01-18",
      "last_seen": "2020-01-18",
      "source": "PassiveTotal"
    }
  ],
  "www.realty-advertising.ru": [
    {
      "firtst_seen": "2019-11-08",
      "last_seen": "2019-11-12",
      "source": "PassiveTotal"
    }
  ],
  "ln-048.rd-00003024.id-11744955.v0.tun.vpnoverdns.com": [
    {
      "firtst_seen": "2017-04-06",
      "last_seen": "2017-04-06",
      "source": "PassiveTotal"
    }
  ],
  "mnen6k7g.info": [
    {
      "firtst_seen": "2010-10-28",
      "last_seen": "2010-10-28",
      "source": "PassiveTotal"
    }
  ]
}
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
