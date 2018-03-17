require 'csv'

class CSVParser
	attr_reader :data

	def initialize(source)
		@data = []
		call(source)
		self
	end

	def call(source)
		CSV.read(source, { header_converters: :symbol, headers: true }).each do |row|
			@data.push({name: row[0], age: row[1].to_i, project_count: row[2].to_i, total_value: row[3].to_i})
		end
	end
end