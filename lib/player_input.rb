# frozen_string_literal: true

module PlayerInput
  def request_and_process_start_coordinate(current_player, chess_board, move)
    loop do
      puts "#{current_player.name}, please enter your starting co-ordinate (e.g. e7): "
      input = gets.chomp.downcase

      if input == 'm'
        open_menu
        next
      end

      unless input.match?(/^[a-h][1-8]$/)
        puts 'Invalid input format. Try something like e2 or d7.'
        next
      end

      coordinate = process_player_input(input)

      if chess_board.enemy_at?(coordinate, current_player.color)
        puts 'That is an enemy piece. Please choose your own piece.'
        next
      end

      return coordinate if move.find_matching_piece(coordinate)

      puts 'No piece found at that location.'
    end
  end

  def request_and_process_end_coordinate(current_player, chess_board, move)
    loop do
      puts "#{current_player.name}, please enter the coordinates to move your #{move.current_piece.name} (e.g. e4):"
      input = gets.chomp.downcase

      if input == 'm'
        open_menu
        next
      end

      unless input.match?(/^[a-h][1-8]$/)
        puts 'Invalid input format. Try something like e2 or d7.'
        next
      end

      coordinate = process_player_input(input)

      # Validate the move
      if move.current_piece.valid_move?(chess_board, move.start_coordinate, coordinate) &&
         current_player.player_piece_match?(move.current_piece)
        return coordinate
      else
        puts 'Not a valid move!'
      end
    end
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
