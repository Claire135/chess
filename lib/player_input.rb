# frozen_string_literal: true

module PlayerInput
  def request_and_process_start_coordinate
    input = start_coordinate_input_prompt
    open_menu if input == 'm'
    process_player_input(input)
  end

  def request_and_process_end_coordinate(piece)
    input = end_coordinate_input_prompt(piece)
    open_menu if input == 'm'
    process_player_input(input)
  end

  def open_menu
    puts "\n=== Game Menu ==="
    puts 's - Save and Exit'
    puts 'q - Quit game'
    puts 'c - Continue playing'

    case gets.chomp.downcase
    when 's'
      save_game
      puts 'Exiting after save.'
      exit
    when 'q'
      puts 'Thanks for playing!'
      exit
    when 'c'
      nil
    else
      puts 'Invalid choice. Returning to game.'
    end
  end

  def play_again_prompt
    puts 'Do you want to play again? (y/n)'
    input = gets.chomp.downcase
    if input == 'y'
      GameLauncher.start
    else
      puts 'Thanks for playing!'
      exit
    end
  end

  def game_start_or_load_prompt
    puts 'Welcome to Chess!'
    puts 'Would you like to start a new game or load a saved one? (n for new, l for load)'
    choice = gets.chomp.downcase

    if choice == 'l'
      load_game
      puts 'Game loaded.'
      puts
    elsif choice == 'n'
      puts
      puts 'Starting a new game... '
      puts
      play_game
    else
      puts 'Invalid choice. Starting a new game.'
    end
  end

  private

  COLUMN_MAP = {
    'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3,
    'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7
  }.freeze

  ROW_MAP = {
    '1' => 7, '2' => 6, '3' => 5, '4' => 4, '5' => 3,
    '6' => 2, '7' => 1, '8' => 0
  }.freeze

  def start_coordinate_input_prompt
    puts 'Please enter your starting co-ordinate (e.g. e7):'
    gets.chomp.downcase
  end

  def end_coordinate_input_prompt(piece)
    puts "Please enter the co-ordinates for where you want to move #{piece.name} (e.g. e4): "
    gets.chomp.downcase
  end

  def process_player_input(input)
    final_array = []
    coordinate_array = input.split('')
    first_coordinate = ROW_MAP[coordinate_array[1]]
    final_array << first_coordinate

    # Find the column number from COLUMN_MAP based on the first coordinate (the letter)
    second_coordinate = COLUMN_MAP[coordinate_array[0]]
    final_array << second_coordinate
    final_array
  end
end
