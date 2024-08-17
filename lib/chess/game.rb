module Chess
  class Game
    def initialize
      @board = ChessBoard.new
      @current_player = "White"
    end

    def play
      loop do
        @board.display
        puts "#{@current_player}'s turn. Enter your move:"
        move_input = gets.chomp
        piece_type, start_pos, dest_pos = NotationParser.parse_move(move_input)

        @board.move_piece(piece_type, start_pos, dest_pos)
      end
    end
  end

end
