class Character
  attr_accessor :name, :region

  @@party_array = ["Democrat", "Republican"]
  @@ideology_array = ["Liberal", "Conservative", "Tea Party", "Socialist", "Neutral"]

  def initialize
    @name
    @region
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def self.list
    if ObjectSpace.each_object(self).to_a.empty?
      puts "Sorry, the list is empty. Select 'Create' to add voters or politicians."
    else
      i = 1
      ObjectSpace.each_object(self).to_a.each do |character|
        if character.is_a? Politician
          puts "#{i}-#{character.name} #{character.party}"
          i+=1
        else
          puts "#{i}-#{character.name} #{character.ideology}"
          i+=1
        end
      end
    end
  end

  def self.update character
      if character.is_a? Politician
        puts "You are changing #{character.name} who is #{character.party}."
        puts "Would you like to change (N)ame or (P)arty?"
        answer = gets.chomp.downcase
        if answer == "n"
          puts "Enter new name."
          character.name = gets.chomp
        elsif answer == "p"
          index = 1
          @@party_array.each do |party|
            puts "#{index} #{party}"
            index += 1
          end
          choice = gets.chomp
          case choice
          when "1" then character.party = @@party_array[0]
          when "2" then character.party = @@party_array[1]
          end
        end
      else
        puts "You are changing #{character.name} who's ideology is #{character.ideology}."
        puts "Would you like to change (N)ame or (I)deology?"
        answer = gets.chomp.downcase
        if answer == "n"
          puts "Enter new name."
          character.name = gets.chomp
        elsif answer == "i"
          index = 1
          @@ideology_array.each do |ideology|
            puts "#{index} #{ideology}"
            index += 1
          end
          choice = gets.chomp
          case choice
          when "1" then character.ideology = @@ideology_array[0]
          when "2" then character.ideology = @@ideology_array[1]
          when "3" then character.ideology = @@ideology_array[2]
          when "4" then character.ideology = @@ideology_array[3]
          when "5" then character.ideology = @@ideology_array[4]
          end
        end
      end
  end

end
