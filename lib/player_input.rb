module PlayerInput
  def request_and_process_start_coordinate
    input = start_coordinate_input_prompt
    process_player_input(input)
  end

  def request_and_process_end_coordinate
    input = end_coordinate_input_prompt
    process_player_input(input)
  end

  private

  COLUMN_MAP = {
    'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3,
    'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7
  }

  def start_coordinate_input_prompt
    puts 'Please enter your starting co-ordinate (e.g. e7):'
    gets.chomp.downcase
  end

  def end_coordinate_input_prompt
    puts "Please enter the co-ordinates for where you want to move #{@current_piece.name} (e.g. e4): "
    gets.chomp.downcase
  end

  def process_player_input(input)
    final_array = []
    coordinate_array = input.split('')
    first_coordinate = coordinate_array[1].to_i - 1
    final_array << first_coordinate
    # letter corresponds to the second coordinate
    second_coordinate = COLUMN_MAP.find { |key, value| key == coordinate_array[0] }
    final_array << second_coordinate[1]
  end
end
