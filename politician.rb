class Politician < Character
  attr_accessor :party

  def initialize
    @party = politician_creator(@@party_array)
  end

  def politician_creator parties
    puts "What is the Politician's name?"
    @name = gets.chomp
    puts "What region is the Politician from?"
    @region = Character.region_select
    puts "Select his/her party affiliation"
    index = 1
    parties.each do |ideo|
      puts "#{index} #{ideo}"
      index += 1
    end
    choice = gets.chomp
    case choice
    when "1" then @@party_array[0]
    when "2" then @@party_array[1]
    else
      puts "That was not a valid choice. Try again."
      politician_creator parties
    end
  end
end
