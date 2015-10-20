require_relative "character"
require_relative "voter"
require_relative "politician"
require_relative "world"
require "CSV"
#intro to program with a clear screen command
def start

  system("clear")

  puts <<-EOP
  **********************************************************
  //  Welcome to the PBR Ultimate voter simulation game!  //
  **********************************************************
  Copyright 2015 PBR crew

  EOP

  main_menu

end

#Choice to create voter or politician. Check to see if 2 opposing politicians
#already created, if so option to create politician removed.

def create
  if !World.politician_check && Politician.all.count < 2
    puts "Would you like to create a (P)olitition or (V)oter? (M)ain menu."
    answer = gets.chomp.downcase
    if answer == "p"
      politician = Politician.new
      puts "#{politician.name} was successfully created."
    elsif answer == "v"
      voter = Voter.new
      puts "#{voter.name} was successfully created."
    elsif answer == "m"
      main_menu
    else
      puts "That was not a valid choice. Try again."
     create
    end
  else
    puts "Would you like to create a (V)oter? (M)ain menu"
    answer = gets.chomp.downcase
    if answer == "v"
      voter = Voter.new
      puts "#{voter.name} was successfully created."
    elsif answer == "m"
      main_menu
    else
      puts "That was not a valid choice. Try again"
      create
    end
  end
  main_menu
end

def list
  puts "Would you like a list of (P)olititions or (V)oters? (M)ain menu."
  answer = gets.chomp.downcase
  if answer == "p"
    Politician.list
  elsif answer == "v"
    Voter.list
  elsif answer == "m"
    main_menu
  else
    puts "That was not a valid choice. Try again."
    list
  end
  main_menu
end

def update
  puts "Would you update a (P)olitition or (V)oter? (M)ain menu."
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
  elsif answer == "m"
    main_menu
  else
    puts "That was not a valid choice. Try again."
    update
  end
  main_menu
end

def modifiers

  puts <<-EOP
    How would you like to add flavor to this election?
    -------------------------------------------------------------------------
    1- Popular republican candidate.
    2- Popular democratic candidate
    (M)ain Menu
  EOP
  answer = gets.chomp.downcase

  case answer
  when "1" then World.rep_vote_modifier_set 30; puts "It's like Lincoln came back to life. Republican chance of winning increased."
  when "2" then World.dem_vote_modifier_set -30; puts "Good old Franklin D. Roosevelt has nothing on you. Democrat chance of winning increased."
  when "m" then main_menu
  else
    puts "That was not a valid choice."
    modifiers
  end
  main_menu
end
# Run the voter simulation in the world class
def vote
  World.voter_sim
  main_menu
end
#link to method that imports voters from CSV file
def load_voters
  begin
    Voter.load_voters
  rescue
    puts "Invalid file name. Please try again."
    sleep 1
    Voter.load_voters
    main_menu
  end
end
# default menu
def main_menu
  puts <<-EOP
     What can we da ya fer?
    ----------------------
    (C)reate
    (I)mport Voters
    (L)ist
    (U)pdate
    (V)ote
    (M)odifiers
    (Q)uit
  EOP

  answer = gets.chomp.downcase

  case answer
    when "c" then create
    when "l" then list
    when "u" then update
    when "v" then vote
    when "m" then modifiers
    when "i" then load_voters
    when "q" then exit
    else
      puts "That was not a valid choice. Try again."
      start
  end
end

start
