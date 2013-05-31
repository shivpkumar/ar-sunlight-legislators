require 'csv'
require_relative '../app/models/legislator'

class SunlightLegislatorsImporter
  def self.import(filename=File.dirname(__FILE__) + "/../db/data/legislators.csv")
    attributes = ['id','title','firstname','lastname','party','state','district',
                  'in_office','gender','phone','fax','website','twitter_id','birthdate']
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      args_hash = {}
      row.each do |field, value|
        if attributes.include?(field)
          if value == '0' || value == '1'
            args_hash[field.to_sym] = value.to_i
          else
            args_hash[field.to_sym] = value
          end
        end
      end
      Legislator.create!(args_hash)
    end
  end
end

# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
