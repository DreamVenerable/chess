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
        piece, destination, capture, promotion = NotationParser.parse_move(move_input)


      end
    end
  end

end
