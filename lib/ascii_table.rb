require 'terminal-table'
require 'optparse'
require 'ostruct'

class AsciiTable

  class AbortError < StandardError; end

  attr_reader :options, :table, :parser

  DELIMITER_MAP = {
    "t" => "\t",
    "0" => "\0",
    "v" => "\v",
    "r" => "\r"
  }

  def initialize(args, reader)
    @table  = nil
    @parser = nil
    @input  = []
    # defaults
    @options = OpenStruct.new(
      :delimiter    => ";",
      :headings     => false,
      :table_align  => :left,
      :cell_align   => {},
      :separator    => ""
    )

    parse_options!(args)
    read_input!(reader)
  end

  def to_s
    generate_table! unless @table
    @table.to_s
  end

  private

  def generate_table!
    @table = ::Terminal::Table.new
    draw_header if @options.header
    add_rows
    align_rows
  end

  def draw_header
    @table.headings = format_line(@input.shift)
  end

  def add_rows
    @input.each do |line|
      if @options.separator == line
        @table.add_separator
      else
        @table.add_row format_line(line)
      end
    end
  end

  def align_rows
    @table.number_of_columns.times do |i|
      alignment = @options.cell_align[i + 1] || @options.table_align
      @table.align_column(i, alignment)
    end
  end

  def exit!(message)
    message = "\nMessage: #{message}\n\n"
    raise AbortError.new(message + @parser.help)
  end

  def format_line(line)
    line.split(@options.delimiter)
  end

  def parse_options!(args)
    OptionParser.new do |opts|
      @parser = opts # HACK

      opts.separator ""

      opts.banner = %(Usage: cat data.csv | #{opts.program_name} -H -d ";" [options])

      opts.on("-d", "--delimiter DELIMITER", "Delimiter. Default: ;") { |d| @options.delimiter = map_delimiter(d) }
      opts.on("-H", "--header", "First line is header. Default: no") { @options.header = true }
      opts.on("-A", "--table-align POSITION", "Align all cells to POSITION. Default left") { |a| @options.table_align = a.to_sym }
      opts.on("-a", "--align COLUMN1=POSITION,...", "All specific cell to. Example 1=left,3=right,4=center") do |a|
        a.split(/,/).each do |b|
          column, position = b.split(/=/)
          @options.cell_align[column.to_i] = position.to_sym
        end
      end
      opts.on("-s", "--separator SEPARATOR", "Add a separator. Default: empty line") { |s| @options.separator = s }

      opts.on("-h", "--help", "Help") { exit!("Help!") }

      opts.separator ""
    end

    @parser.parse!(args)

  rescue OptionParser::InvalidOption => e
    exit!(e.message)
  end

  def map_delimiter(delimiter)
    # TODO refactor
    parts = delimiter.split(/\\/).reject { |part| part.empty? }.map do |part|
      DELIMITER_MAP[part] || part
    end
    parts.join("")
  end

  def read_input!(reader)
    exit!("Need input!") if reader.tty?

    @input = reader.readlines.map { |l| l.chomp }

    exit!("Empty input") if @input.empty?
    exit!("Need rows!") if @options.header && @input.size == 1
  end

end
