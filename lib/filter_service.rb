require './lib/string'

class FilterService
	def initialize(data, arguments)
		@data, @arguments = data, arguments
		call
	end

	def print_header
		puts @data.first.keys.map{|x| x.to_s.camelize }.join " | "
	end

	def print_results(flag, result)
		case flag
		when :total
			puts "#{result[0]}: #{result[1]}"
		else
			print_header
			result.each do |r|
				puts r.values.join " | "
			end
		end
	end

	def to_camel_case(string)
		string.split("_").each {|s| s.capitalize! }.join("")
	end

	def to_underscore(string)
		string.scan(/[A-Z][a-z]*/).join("_").downcase
	end

	def call
		if !@arguments.fetch(:order_by).empty?
			result = 	if @arguments.fetch(:order_by)[1] == "asc"
									@data.sort_by!{ |x| x[@arguments.fetch(:order_by)[0].to_sym] }
								else
									@data.sort_by!{ |x| x[@arguments.fetch(:order_by)[0].to_sym] }.reverse!
								end

			print_results(:order_by, result)
		elsif !@arguments.fetch(:find).empty?
			result = []
			@arguments.fetch(:find).each do |find_value|
				value = @data.find{ |x| x[:name] == find_value }
				if !!value
					result.push(value)
				end
			end

			print_results(:find, result)
		elsif !!@arguments.fetch(:total)
			result = []
			result.push @arguments.fetch(:total)
			result.push(@data.map{ |t| t[@arguments.fetch(:total).underscore.to_sym]}.inject(0, :+))

			print_results(:total, result)
		else
			print_results(:none, @data)
		end
	end
end