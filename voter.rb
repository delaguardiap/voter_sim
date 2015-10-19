class Voter < Character
  attr_accessor :ideology

  def initialize(ideology = voter_creator(@@ideology_array))
    @ideology = ideology
  end
  # create new voter from user input with feedback that voter was created
  def voter_creator ideologies
    puts "What is the voter's name?"
    @name = gets.chomp
    puts "What region is the Voter from?"
    @region = Character.region_select
    puts "Select voter's party affiliation:"
    index = 1
    ideologies.each do |ideo| #lists ideologies for user to select
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

  # method to import CSV data to Voter class with feedback as to number
  #of voters created
  def self.load_voters
    puts "Please enter the file name or (M)ain Menu:"
    file_name = gets.chomp
    if file_name == ""
      main_menu
    elsif file_name.downcase == "m"
      main_menu
    else
      voters = CSV.read("./#{file_name}")
      voters_loaded_count = 0
      voters.each do |voter|
        if voter[0]
          new_voter = Voter.new(voter[1])
          new_voter.name = voter[0]
          new_voter.region = voter[2]
          voters_loaded_count += 1
        end
      end
    end
    puts "#{voters_loaded_count} voters loaded."
  end
end
