module Chess
  class Game
    def initialize
      @board = ChessBoard.new
      @current_player = :white
    end

    def play
      loop do
        @board.display
        puts "#{@current_player.capitalize}'s turn. Enter your move:"
        get_player_input
        move
      end
    end

    def get_player_input
      input = gets.chomp
      if valid_notation?(input)
        parse_input(input)
      else
        puts "Invalid notation. Please enter your move in the following format: (e.g., e1b5)."
        get_player_input # Ask the user again
      end
    end

    def valid_notation?(input)
      # Validate that input
      input.match?(/\A[a-h][1-8][a-h][1-8]\z/)
    end

    def parse_input(input)
      @start_pos, @dest_pos = NotationParser.parse_move(input)
    end

    def move
      # Validates move, stops if move is invalid
      return "Invalid move. Please try again." unless valid_move?(@start_pos, @dest_pos)

      # If move is valid, moves piece
      @board.move_piece(@start_pos, @dest_pos)

      # Allows promotion when allowed
      promotion

      # Switches players
      switch_player
    end

    def promotion
      SpecialMoves::Promotion.promote(@dest_pos, @board.board) if SpecialMoves::Promotion.promote?(@dest_pos, @board.board)
    end

    def valid_move?(start_pos, dest_pos)
    piece_class = @board.board[start_pos[0]][start_pos[1]]

      # Validates move
      return false unless piece_class.is_a?(Piece) && piece_class.color == @current_player
      piece_class.valid_move?(start_pos, dest_pos, @board.board) && !move_leaves_king_checked?(start_pos, dest_pos)
    end

    def find_king_position(board = @board.board)
      board.each_with_index do |rank, r|
        rank.each_with_index do |square, f|
          return [r, f] if square.is_a?(King) && square.color == @current_player
        end
      end
    end

    def find_piece_positions(board = @board.board)
      pieces = []
      board.each_with_index do |rank, r|
        rank.each_with_index do |square, f|
          next unless square.is_a?(Piece) && square.color != @current_player
          pieces << [square, [r, f]]
        end
      end
      pieces
    end

    def move_leaves_king_checked?(start_pos, dest_pos)
      # Duplicates the board
      board_clone = @board.board.map(&:dup)

      # Simulates the move
      piece = board_clone[start_pos[0]][start_pos[1]]
      board_clone[start_pos[0]][start_pos[1]], board_clone[dest_pos[0]][dest_pos[1]] = ' ', piece

      # Find the kings' position after the move
      king_pos = find_king_position(board_clone)

      # Checks if any opponent piece can attack the king's position
      find_piece_positions(board_clone).each do |piece_class, position|
        return true if piece_class.valid_move?(position, king_pos, board_clone)
      end

      false
    end

    def switch_player
      @current_player = @current_player == :white ? :black : :white
    end
  end
end
