require_relative "character"
require_relative "voter"
require_relative "politician"
require_relative "world"
require "CSV"

# politician = Politician.new
# p Politician.all

voters = CSV.read("./voters.csv")

voters.each do |voter|
  p voter if voter[0]
end
