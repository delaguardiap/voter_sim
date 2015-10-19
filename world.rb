class World

  #Set of class variables which will keep track of most counters.
  @@dem_vote = 0
  @@rep_vote = 0
  @@home_town_fav_democrat = 0
  @@home_town_fav_republican = 0
  @@dem_vote_modifier = 0
  @@rep_vote_modifier = 0

  #vote modifiers will
  def self.dem_vote_modifier_set value
    @@dem_vote_modifier += value
  end

  def self.rep_vote_modifier_set value
    @@rep_vote_modifier += value
  end

  #Will go through each element of the voter's array and will call one of the 5 vote function on said voter
  #depending on his ideology.
  def self.voter_sim
    @@dem_vote = 1
    @@rep_vote = 1
    @@home_town_fav_democrat = 0
    @@home_town_fav_republican = 0
    if sim_check
      Voter.all.each do |voter|
        case voter.ideology
          when "Liberal" then liberal_vote(voter, Politician.all)
          when "Conservative" then conservative_vote(voter, Politician.all)
          when "Tea Party" then tea_party_vote(voter, Politician.all)
          when "Socialist" then socialist_vote(voter, Politician.all)
          when "Neutral" then neutral_vote(voter, Politician.all)
        end
      end
        countdown
        winner
    else
        puts "Cannot run simulation, do not have one Democrat and one Republican, and at least one voter."
        main_menu
    end
  end

  #General validation to run the simulation
  def self.sim_check
    Voter.all.count > 0 && politician_check
  end

  def self.politician_check
    rep_found = false
    dem_found = false
    if Politician.all.count == 2
      Politician.all.each do |pol|
        if pol.party == "Republican"
          rep_found = true
        else
          dem_found = true
        end
      end
    end
    rep_found && dem_found
  end

  #Will check if the voter and politician are from the same region, in case they
  #It will improve the chances of the voter voting for the politician.
  def self.home_town_fav_check(voter, politicians)
     if politicians[0].region == politicians[1].region
     rand(99)
    elsif politicians[0].region == voter.region && politicians[0].party == "Democrat"
      @@home_town_fav_democrat += 1
      @@dem_vote_modifier += 10
      roll = rand(99) - @@dem_vote_modifier
      @@dem_vote_modifier = 0
      roll
    elsif politicians[1].region == voter.region && politicians[1].party == "Democrat"
      @@home_town_fav_democrat += 1
      @@dem_vote_modifier += 10
      roll = rand(99) - @@dem_vote_modifier
      @@dem_vote_modifier = 0
      roll
    elsif politicians[0].region == voter.region && politicians[0].party == "Republican"
      @@home_town_fav_republican += 1
      @@rep_vote_modifier += 10
      roll = rand(99) - @@rep_vote_modifier
      @@rep_vote_modifier = 0
      roll
      elsif politicians[1].region == voter.region && politicians[1].party == "Republican"
      @@home_town_fav_republican += 1
      @@rep_vote_modifier += 10
      roll = rand(99) - @@rep_vote_modifier
      @@rep_vote_modifier = 0
      roll
    else
      rand(99)
    end
  end

  #Voting methods
  def self.liberal_vote(voter, politicians)
    roll = home_town_fav_check(voter, politicians)
    if roll < 0
      roll = 0
    elsif roll > 100
      roll = 100
    else
      roll
    end
    roll.between?(0, 74) ? @@dem_vote += 1 : @@rep_vote += 1
  end

  def self.conservative_vote(voter, politicians)
    roll = home_town_fav_check(voter, politicians)
    if roll < 0
      roll = 0
    elsif roll > 100
      roll = 100
    else
     roll
    end
     roll.between?(0, 24) ? @@dem_vote += 1 : @@rep_vote += 1
  end

  def self.tea_party_vote(voter, politicians)
    roll = home_town_fav_check(voter, politicians)
    if roll < 0
      roll = 0
    elsif roll > 100
      roll = 100
    else
      roll
    end
     roll.between?(0, 9) ? @@dem_vote += 1 : @@rep_vote += 1
  end

  def self.socialist_vote(voter, politicians)
     roll = home_town_fav_check(voter, politicians)
     if roll < 0
       roll = 0
     elsif roll > 100
       roll = 100
     else
       roll
     end
     roll.between?(0, 89) ? @@dem_vote += 1 : @@rep_vote += 1
  end

  def self.neutral_vote(voter, politicians)
    roll = home_town_fav_check(voter, politicians)
    if roll < 0
      roll = 0
    elsif roll > 100
      roll = 100
    else
      roll
    end
    roll.between?(0, 49) ? @@dem_vote += 1 : @@rep_vote += 1
  end

  def self.countdown
    i = 3
    while i > 0
      puts "#{i}"
      sleep 1
      i -= 1
    end
  end

  #A methods that displays the election's results
  def self.vote_tally
    puts "Total votes cast: #{@@rep_vote + @@dem_vote}"
    puts "Total Republican votes: #{@@rep_vote}"
    puts "Total Democrat votes:   #{@@dem_vote}"
    puts "Hometown Democrat favorite bonus: #{@@home_town_fav_democrat}"
    puts "Hometown Republican favorite bonus: #{@@home_town_fav_republican}"
  end

  #A methods that calculates the winner
  def self.winner
    puts "The results are in!"
    if @@dem_vote > @@rep_vote
      Politician.all.each do |pol|
       if pol.party == "Democrat"
         puts "The winner is #{pol.name}!"
         vote_tally
       end
     end
    elsif @@rep_vote > @@dem_vote
      Politician.all.each do |pol|
       if pol.party == "Republican"
         puts "The winner is #{pol.name}!"
         vote_tally
       end
     end
   else
     vote_tally
     puts "Its a draw, cage battle to the death!"
     puts "After a brutal fight #{Politician.all.sample.name} has emerged victorious."
   end
  end
end
