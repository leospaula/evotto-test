require './lib/csv_parser'
require './lib/filter_service'
require 'slop'

class CLI

	def cli_flags
    options = Slop::Options.new
    options.banner =  "usage: ruby app.rb [options] ..."
    options.separator ""
    options.separator "Options:"
    options.string '-s', '--source', 'Source file with path(required)', required: true
    options.string '-t', '--total', 'Sum of column, can be: [TotalValue,Age,ProjectCount]'
    options.array '-f', '--find', 'Find Records using the given names (Use one or more names seperated by ":")', delimiter: ':'
		options.array '-o', '--order_by', 'Order values: [age|project_count|total_value:asc|desc]', delimiter: ':', limit: 2

    options
  end

  def parse_arguments(command_line_options, parser)
    begin
      result = parser.parse command_line_options
      result.to_hash

    rescue Slop::UnknownOption
      puts cli_flags
      exit
    end
  end

  def flags
    [:source, :total, :find, :order_by]
  end

  def flags_error
    switches = flags.collect {|f| "--#{f}"}
    puts cli_flags
    puts
    abort "please set one of #{switches}"
  end

  def validate_arguments(arguments)
    if set?(arguments, :total)
      unless %w(TotalValue Age ProjectCount).include? arguments.fetch(:total)
      	abort "Total flag (--total) must be TotalValue, Age or ProjectCount"
      end
    end
    if set?(arguments, :order_by)
      unless %w(total_value age project_count).include? arguments.fetch(:order_by)[0]
      	abort "First value of Order_by flag (--order_by) must be total_value, age or project_count"
      end
      unless !!arguments.fetch(:order_by)[1]
      	arguments.fetch(:order_by).push("asc")
      end

      unless %w(asc desc).include? arguments.fetch(:order_by)[1]
      	abort "Second value of Order_by flag (--order_by) must be asc or desc"
      end
    end
  end

  def set?(arguments, flag)
  	arguments.fetch(flag).is_a?(Array) ? !arguments.fetch(flag).empty? : !!arguments.fetch(flag)
  end

  def main(command_line_options=ARGV)
    parser = Slop::Parser.new cli_flags
    arguments = parse_arguments(command_line_options, parser)
    validate_arguments arguments

    csv = CSVParser.new arguments.fetch(:source)
    FilterService.new(csv.data, arguments)
  end

end

CLI.new.main if !defined?(RSpec)