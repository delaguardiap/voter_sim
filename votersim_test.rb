require_relative "character"
require_relative "voter"
require_relative "politician"
require_relative "world"
require "CSV"

# politician = Politician.new
# p Politician.all
rep_found = false
dem_found = false

Voter.load_voters

Voter.list
Politician.new
Politician.new
  Politician.all
  if Politician.all.count == 2
    Politician.all.each do |pol|
    if pol.party == "Republican"
      rep_found = true
    else
      dem_found = true
    end
  end
  if rep_found && dem_found
    puts "yeehaw!"
  else
    puts "uz done fuk'd up!"
  end
end
