module Chess
  class Game
    def initialize
      @board = ChessBoard.new
      @current_player = :white
    end

    def play
      @board.display
      loop do
        # Gets player input
        puts "#{@current_player.capitalize}'s turn. Enter your move:"
        get_player_input

        # Moves piece
        move

        # Update display
        @board.display

        # Ends game if checkmate
        # puts "Checkmate: #{checkmate?}"
        # break if checkmate?

        # Switches players
        switch_player
        puts "#{@current_player} in check: #{check?(find_king_position(@current_player))}"
      end
    end

    def get_player_input
      loop do
        input = gets.chomp
        if valid_notation?(input)
          parse_input(input)
          break
        else
          puts "Invalid notation. Please enter your move in the following format: (e.g., e1b5)."
        end
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
      loop do
        # Validates move, stops if move is invalid
        if valid_move?(@start_pos, @dest_pos)
          # Move piece
          @board.move_piece(@start_pos, @dest_pos)

          # Allows promotion when allowed
          promotion
          break
        else
          puts "Invalid move. Please try again."
          get_player_input
        end
      end
    end

    def promotion
      SpecialMoves::Promotion.promote(@dest_pos, @board.board) if SpecialMoves::Promotion.promote?(@dest_pos, @board.board)
    end

    def valid_move?(start_pos, dest_pos, color = @current_player)
      piece_class = @board.board[start_pos[0]][start_pos[1]]

      # Validates move
      return false unless piece_class.is_a?(Piece) && piece_class.color == color
      return false unless piece_class.valid_move?(start_pos, dest_pos, @board.board)

      true
      # !move_leaves_king_checked?(start_pos, dest_pos)
    end

    def find_king_position(color)
      @board.board.each_with_index do |rank, r|
        rank.each_with_index do |square, f|
          return [r, f] if square.is_a?(King) && square.color == color
        end
      end
    end

    def find_piece_positions(color)
      pieces = []
      @board.board.each_with_index do |rank, r|
        rank.each_with_index do |square, f|
          next unless square.is_a?(Piece) && square.color == color
          pieces << [square, [r, f]]
        end
      end
      pieces
    end

    # def move_leaves_king_checked?(start_pos, dest_pos)
    #   # Stimulate move
    #   stimulate_move(start_pos, dest_pos)
    #
    #   # Checks if king be in check
    #   check_result = check?(find_king_position)
    #
    #   # Undo move stimulation
    #   stimulate_move(dest_pos, start_pos)
    #
    #   # Return result
    #   check_result
    # end

    # def stimulate_move(start_pos, dest_pos)
    #   @board.board[dest_pos[0]][dest_pos[1]] = @board.board[start_pos[0]][start_pos[1]]
    #   @board.board[start_pos[0]][start_pos[1]] = ' '
    # end

    def check?(king_pos)
      # Checks if any opponent piece can attack the king's position
      find_piece_positions(@current_player == :white ? :black : :white).each do |piece_class, position|
        return true if valid_move?(position, king_pos, @current_player == :white ? :black : :white)
      end
      false
    end

    # def checkmate?
    #   return false unless check?(find_king_position)
    #   @board.board.each_with_index do |rank, r|
    #     rank.each_with_index do |square, f|
    #       next unless square.is_a?(Piece) && square.color == @current_player
    #       valid_moves = find_valid_moves([r, f], square)
    #       valid_moves.each do |move|
    #         return false unless move_leaves_king_checked?([r, f], move)
    #       end
    #     end
    #   end
    #   puts "Checkmate! #{@current_player.capitalize} wins!"
    #   true
    # end

    # def find_valid_moves(start_pos, piece)
    #   valid_moves = []
    #   8.times do |r|
    #     8.times do |f|
    #       dest_pos = [r, f]
    #       valid_moves << dest_pos if piece.valid_move?(start_pos, dest_pos, @board.board)
    #     end
    #   end
    #   valid_moves
    # end

    def switch_player
      @current_player = @current_player == :white ? :black : :white
    end
  end
end
