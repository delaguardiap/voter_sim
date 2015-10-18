require_relative "character"
require_relative "voter"
require_relative "politician"
require_relative "world"
require "CSV"

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


def create
  if World.politician_check == false
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

def vote
  World.voter_sim
  main_menu
end

def load_voters
  Voter.load_voters
  main_menu
end

def main_menu
  puts <<-EOP
     What can we da ya fer?
    ----------------------
    (C)reate
    (I)mport Voters
    (L)ist
    (U)pate
    (V)ote
    (Q)uit
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
    when "i"
      load_voters
    when "q"
      exit
    else
      puts "That was not a valid choice. Try again."
      start
  end
end

start
