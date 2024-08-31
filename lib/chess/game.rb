module Chess
  class Game
    def initialize(first_player = :white)
      @board = ChessBoard.new
      @current_player = first_player
      @opponent = (first_player == :white ? :black : :white)
    end

    def play
      @board.display
      loop do
        # Gets player input
        puts "#{@current_player.capitalize}'s turn. Enter your move:"
        get_player_input

        # Moves piece
        move

        # Switches players
        switch_player

        # Update display
        @board.display

        puts "Check!" if check?(find_king_position(@current_player))

        # Ends game if checkmate
        exit if checkmate?
      end
    end

    def get_player_input
      loop do
        input = gets.chomp
        if input == 'q'
          p "Saving and exiting..."
          exit
        elsif castling_notation?(input)
          if SpecialMoves::Castling.castling(input, @board.board, @current_player)
            switch_player
            play
          else
            puts "Unable to castle!"
          end
        else
          if valid_notation?(input)
            parse_input(input)
            break
          else
            puts "Invalid notation. Please enter your move in the following format: (e.g., e1b5)."
          end
        end
      end
    end

    def castling_notation?(input)
      ['0-0', '0-0-0'].any?(input)
    end

    def valid_notation?(input)
      input.match?(/\A[a-h][1-8][a-h][1-8]\z/)
    end

    def parse_input(input)
      @start_pos, @dest_pos = NotationParser.parse_move(input)
    end

    def move
      loop do
        # Validates move, stops if move is invalid
        if valid_move?(@start_pos, @dest_pos) && !move_leaves_king_checked?
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

    def valid_move?(start_pos, dest_pos, board = @board.board, color = @current_player)
      piece_class = board[start_pos[0]][start_pos[1]]

      # Validates move
      return false unless piece_class.is_a?(Piece) && piece_class.color == color
      return false unless piece_class.valid_move?(start_pos, dest_pos, board)

      true
    end

    def find_king_position(color, board = @board.board)
      board.each_with_index do |rank, r|
        rank.each_with_index do |square, f|
          return [r, f] if square.is_a?(King) && square.color == color
        end
      end
    end

    def find_piece_positions(color, board = @board.board)
      pieces = []
      board.each_with_index do |rank, r|
        rank.each_with_index do |square, f|
          next unless square.is_a?(Piece) && square.color == color
          pieces << [square, [r, f]]
        end
      end
      pieces
    end

    def move_leaves_king_checked?(start_pos = @start_pos, destination = @dest_pos)
      # Clone & Stimulate move
      board = Marshal.load(Marshal.dump(@board.board))
      stimualte_move(start_pos, destination, board)

      # Checks if king be in check
      check_result = check?(find_king_position(@current_player, board), board)

      # Return result
      check_result
    end

    def stimualte_move(start_pos, destination, board)
      board[destination[0]][destination[1]] = board[start_pos[0]][start_pos[1]]
      board[start_pos[0]][start_pos[1]] = ' '
    end

    def check?(king_pos, board = @board.board)
      # Checks if any opponent piece can attack the king's position
      find_piece_positions(@opponent, board).each do |piece_class, position|
        return true if valid_move?(position, king_pos, board, @opponent)
      end
      false
    end

    def checkmate?
      return false unless check?(find_king_position(@current_player))
      @board.board.each_with_index do |rank, r|
        rank.each_with_index do |square, f|
          next unless square.is_a?(Piece) && square.color == @current_player
          valid_moves = find_valid_moves([r, f], square)
          valid_moves.each do |move|
            return false unless move_leaves_king_checked?([r, f], move)
          end
        end
      end
      puts "Checkmate! #{@opponent.capitalize} wins!"
      true
    end

    def find_valid_moves(start_pos, piece)
      valid_moves = []
      8.times do |r|
        8.times do |f|
          dest_pos = [r, f]
          valid_moves << dest_pos if piece.valid_move?(start_pos, dest_pos, @board.board)
        end
      end
      valid_moves
    end

    def switch_player
      @current_player, @opponent = @opponent, @current_player
    end
  end
end
