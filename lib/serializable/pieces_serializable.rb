module PiecesSerializable
  def to_h
    {
      class_name: self.class.name,
      color: @color,
      position: @position,
      symbol: @symbol,
      name: @name,
      move_count: @move_count
    }
  end

  def self.from_h(hash)
    klass = Object.const_get(hash['class_name'])
    klass.new(hash['color'], hash['position'], hash['symbol'],
              hash['name']).tap do |pieces|
      pieces.move_count = hash['move_count']
    end
  end
end
