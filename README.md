[github]: https://github.com/neopoly/ascii_table
[doc]: http://rubydoc.info/github/neopoly/ascii_table/master/file/README.md
[gem]: https://rubygems.org/gems/ascii_table
[travis]: https://travis-ci.org/neopoly/ascii_table
[codeclimate]: https://codeclimate.com/github/neopoly/ascii_table
[inchpages]: https://inch-ci.org/github/neopoly/ascii_table

# AsciiTable

Create ascii table from command line using [terminal-table](https://github.com/tj/terminal-table/)

[![Travis](https://img.shields.io/travis/neopoly/ascii_table.svg?branch=master)][travis]
[![Gem Version](https://img.shields.io/gem/v/ascii_table.svg)][gem]
[![Code Climate](https://img.shields.io/codeclimate/github/neopoly/ascii_table.svg)][codeclimate]
[![Test Coverage](https://codeclimate.com/github/neopoly/ascii_table/badges/coverage.svg)][codeclimate]
[![Inline docs](https://inch-ci.org/github/neopoly/ascii_table.svg?branch=master&style=flat)][inchpages]

[Gem][gem] |
[Source][github] |
[Documentation][doc]

## Installation

Install it yourself as:

```shell
gem install ascii_table
```

## Usage

```shell
$ ascii_table -h

Message: Help!

Usage: cat data.csv | ascii_table -H -d ";" [options]

    -d, --delimiter DELIMITER        Delimiter. Default: ;
    -H, --header                     First line is header. Default: no
    -A, --table-align POSITION       Align all cells to POSITION. Default left
    -a, --align COLUMN1=POSITION,... All specific cell to. Example 1=left,3=right,4=center
    -s, --separator SEPARATOR        Add a separator. Default: empty line
    -h, --help                       Help

```


## Contributing

1. Fork it ( https://github.com/neopoly/ascii_table/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
