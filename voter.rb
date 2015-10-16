class Voter < Character

  def initialize
    @ideology = voter_creator(@@ideology_array)
  end

  @@ideology_array = ["Dirty commie", "Right wing nut"]

  def voter_creator ideologies
    puts "What is the voter's name?"
    @name = gets.chomp
    puts "Select party affiliation"
    index = 1
    ideologies.each do |ideo|
      puts "#{index} #{ideo}"
      index += 1
    end
    choice = gets.chomp
    case choice
    when "1" then @@ideology_array[0]
    when "2" then @@ideology_array[1]
    else
      puts "That was not a valid choice"
      voter_creator ideologies
    end
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

end
