module UIable
  def turn_message
    puts "#{@current_player.name}'s turn:"
  end

  def check_message
    return unless @win.in_check_piece

    color = @win.in_check_piece.color.capitalize
    puts "#{color} king is in check!"
  end

  def score_message
    puts "White Player's Score: #{@white_player.score}"
    puts "Black Player's Score: #{@black_player.score}"
  end

  def checkmate_message
    if @win.in_check_piece.color == 'white'
      puts "Checkmate! #{@black_player.name} wins!"
    else
      puts "Checkmate! #{@white_player.name} wins!"
    end
  end

  def capture_message(move)
    puts "#{@move.captured_piece.name} has been captured!"
  end
end
