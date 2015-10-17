class Character
  def initialize
    @name
    @region
  end

  def self.all
    ObjectSpace.each_object(self).to_a
  end
  
end
