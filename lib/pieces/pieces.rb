# frozen_string_literal: true

# instance variables @color, @alive, @position and @symbol added to Piece Class
# set up Knight Class to inherit variables and methods from Piece Superclass
# Piece Class contains generic methods specific

require_relative '../serializable/base_serializable'

class Pieces
  include BaseSerializable

  attr_accessor :color, :position, :alive, :symbol, :name, :move_count

  def initialize(color, position, symbol, name)
    @color = color
    @position = position
    @symbol = symbol
    @name = name
    @move_count = 0
  end

  def on_board?(row, col)
    row.between?(0, 7) && col.between?(0, 7)
  end

  def count_moves
    @move_count += 1
  end

  # useful for queens and castles
  def horizontal_move?(start_coordinates, end_coordinates)
    start_row, = start_coordinates
    end_row, = end_coordinates
    start_row == end_row
  end

  # useful for queens and castles
  def vertical_move?(start_coordinates, end_coordinates)
    _, start_col = start_coordinates
    _, end_col = end_coordinates
    start_col == end_col
  end

  # useful for queens and bishops
  def diagonal_move?(start_coordinates, end_coordinates)
    row1, col1 = start_coordinates
    row2, col2 = end_coordinates
    (row2 - row1).abs == (col2 - col1).abs
  end

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
