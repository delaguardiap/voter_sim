class World

  @@dem_vote = 0
  @@rep_vote = 0
  @@home_town_fav_democrat = 0
  @@home_town_fav_republican = 0

  def self.voter_sim
    @@dem_vote = 0
    @@rep_vote = 0
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

  def self.home_town_fav_check(voter, politicians)
    @@home_town_fav_democrat = 0
    @@home_town_fav_republican = 0
     if politicians[0].region == politicians[1].region
     rand(99)
    elsif politicians[0].region == voter.region && politicians[0].party == "Democrat"
      @@home_town_fav_democrat += 1
      rand(99) - 10
    elsif politicians[1].region == voter.region && politicians[1].party == "Democrat"
      @@home_town_fav_democrat += 1
      rand(99) - 10
    elsif politicians[0].region == voter.region && politicians[0].party == "Republican"
      @@home_town_fav_republican += 1
      rand(99) + 10
    elsif politicians[1].region == voter.region && politicians[1].party == "Republican"
      @@home_town_fav_republican += 1
      rand(99) + 10
    else
      rand(99)
    end
  end

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
    else roll > 100
      roll = 100
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

  def self.vote_tally
    puts "Total votes cast: #{@@rep_vote + @@dem_vote}"
    puts "Total Republican votes: #{@@rep_vote}"
    puts "Total Democrat votes:   #{@@dem_vote}"
    puts "Hometown Democrat favorite bonus: #{@@home_town_fav_democrat}"
    puts "Hometown Republican favorite bonus: #{@@home_town_fav_republican}"
  end

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
     puts "Its a draw, cage battle to death!"
   end
  end

end
