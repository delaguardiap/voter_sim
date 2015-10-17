class World

  @@dem_vote = 0
  @@rep_vote = 0

  def self.voter_sim
    Voter.all.each do |voter|
      case voter.ideology
        when "Liberal" then liberal_vote
        when "Conservative" then conservative_vote
        when "Tea Party" then tea_party_vote
        when "Socialist" then socialist_vote
        when "Neutral" then neutral_vote
      end
    end
      countdown
      winner
  end

  def self.liberal_vote
    roll = rand(99)
    roll.between?(0, 74) ? @@dem_vote += 1 : @@rep_vote += 1
  end

  def self.conservative_vote
    roll = rand(100)
    roll.between?(0, 24) ? @@dem_vote += 1 : @@rep_vote += 1
  end

  def self.tea_party_vote
    roll = rand(100)
    roll.between?(0, 9) ? @@dem_vote += 1 : @@rep_vote += 1
  end

  def self.socialist_vote
    roll = rand(100)
    roll.between?(0, 89) ? @@dem_vote += 1 : @@rep_vote += 1
  end

  def self.neutral_vote
    roll = rand(100)
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

  def self.winner
    puts "The results are in!"
    if @@dem_vote > @@rep_vote
      Politician.all.each do |pol|
       if pol.party == "Democrat"
         puts "The winner is #{pol.name}!"
       end
     end
    elsif @@rep_vote > @@dem_vote
      Politician.all.each do |pol|
       if pol.party == "Republican"
         puts "The winner is #{pol.name}!"
       end
     end
   else
     puts "Its a draw, cage battle to death!"
   end
  end

end
