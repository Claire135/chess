# use .tap because score is set internally - not as an argument for initialize.

module PlayerSerializable
  def to_h
    {
      name: @name,
      score: @score,
      color: @color
    }
  end

  def self.from_h(hash)
    Player.new(hash['name'], hash['color']).tap do |player|
      player.score = hash['score']
    end
  end
end
