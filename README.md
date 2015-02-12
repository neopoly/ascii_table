# AsciiTable

Create ascii table from command line using [terminal-table](https://github.com/tj/terminal-table/)

## Installation

Install it yourself as:

```shell
gem install ascii_table
```

## Usage

```shell
ascii_table -h

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

1. Fork it ( https://github.com/neopoly/ascii\_table/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
