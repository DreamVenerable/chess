module Chess
  class Game
    def initialize
      @board = ChessBoard.new
      @current_player = :white
    end

    def play
      loop do
        @board.display
        puts "#{@current_player}'s turn. Enter your move:"
        move_input = gets.chomp
        piece, start_pos, dest_pos = NotationParser.parse_move(move_input)

        if valid_move?(piece, start_pos, dest_pos)
          @board.move_piece(piece, start_pos, dest_pos)
          switch_player
        else
          puts "Invalid move. Please try again."
        end
      end
    end

    def valid_move?(piece, start_pos, dest_pos)
      piece_class = @board.board[start_pos[0]][start_pos[1]]
      if piece_class.is_a?(Piece) && piece_class.color == @current_player
        piece_class.valid_move?(start_pos, dest_pos, @board.board)
      else
        false
      end
    end

    def switch_player
      @current_player = @current_player == :white ? :black : :white
    end
  end

end