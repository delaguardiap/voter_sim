require_relative "character"
require_relative "voter"
require_relative "politician"
require_relative "world"
require "CSV"

# politician = Politician.new
# p Politician.all

Voter.load_voters

Voter.list
