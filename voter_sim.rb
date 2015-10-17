require_relative "character"
require_relative "voter"
require_relative "politician"
require_relative "world"

def start

  puts <<-EOP
  **********************************************************
  //  Welcome to the PBR Ultimate voter simulation game!  //
  **********************************************************
  Copyright 2015 PBR crew

  EOP

  main_menu

end


def create
  puts "Would you like to create a (P)olitition or (V)oter?"
  answer = gets.chomp.downcase
  if answer == "p"
    politician = Politician.new
    puts "#{politician.name} was successfully created."
  elsif answer == "v"
    voter = Voter.new
    puts "#{voter.name} was successfully created."
  else
    puts "That was not a valid choice. Try again."
   create
  end
  main_menu
end

def list
  puts "Would you like a list of (P)olititions or (V)oters? "
  answer = gets.chomp.downcase
  if answer == "p"
    Politician.list
  elsif answer == "v"
    Voter.list
  else
    puts "That was not a valid choice. Try again."
    list
  end
  main_menu
end

def update
  puts "Would you update a (P)olitition or (V)oter? "
  answer = gets.chomp.downcase
  if answer == "p"
    Politician.list
    puts "Enter politician number"
    poli_number = gets.chomp.to_i
    Politician.update(Politician.all[poli_number-1])
  elsif answer == "v"
    Voter.list
    puts "Enter voter number"
    poli_number = gets.chomp.to_i
    Voter.update(Voter.all[poli_number-1])
  else
    puts "That was not a valid choice. Try again."
    update
  end
  main_menu
end

def vote
  World.voter_sim
end

def main_menu
  puts <<-EOP
     What can we da ya fer?
    ----------------------
    (C)reate
    (L)ist
    (U)pate
    (V)ote
  EOP

  answer = gets.chomp.downcase

  case answer
    when "c"
      create
    when "l"
      list
    when "u"
      update
    when "v"
      vote
    else
      puts "That was not a valid choice. Try again."
      start
  end
end

start
