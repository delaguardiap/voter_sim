class Voter < Character
  attr_accessor :ideology

  def initialize(ideology = voter_creator(@@ideology_array))
    @ideology = ideology
  end

  def voter_creator ideologies
    puts "What is the voter's name?"
    @name = gets.chomp
    puts "Select voter's party affiliation:"
    index = 1
    ideologies.each do |ideo|
      puts "#{index} #{ideo}"
      index += 1
    end
    choice = gets.chomp
    case choice
    when "1" then @@ideology_array[0]
    when "2" then @@ideology_array[1]
    when "3" then @@ideology_array[2]
    when "4" then @@ideology_array[3]
    when "5" then @@ideology_array[4]
    else
      puts "That was not a valid choice. Try again."
      voter_creator ideologies
    end
  end

  def self.load_voters
    voters = CSV.read("./voters.csv")
    voters_loaded_count = 0
    voters.each do |voter|
      if voter[0]
        new_voter = Voter.new(voter[1])
        new_voter.name = voter[0]
        new_voter.region = voter[2]
        voters_loaded_count += 1
      end
    end
    puts "#{voters_loaded_count} voters loaded."
  end
end
