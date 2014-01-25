class Position
  attr_accessor :coordinates, :belongs_to, :rank0, :rank1
  
  def initialize(coord)
    @coordinates = coord 
    @belongs_to = nil
    @rank0 = nil
    @rank1 = nil
  end
  
  
  def to_s
    "Position string representation:\nCoordinates:#{@coordinates}\nBelongs to:#{@belongs_to}\nRank Player[0]=#{@rank0}\nRank Player[1]=#{@rank1}\n"
  end
  
  
end