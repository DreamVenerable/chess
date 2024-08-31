module Chess
  module SpecialMoves
    module Promotion
      def self.promote?(pos, board)
        piece = board[pos[0]][pos[1]]
        return true if (piece.is_a?(Pawn)) && ((piece.color == :white && pos[0] == 7) || (piece.color == :black && pos[0] == 0))
      end

      def self.promote(pos, board)
        piece = board[pos[0]][pos[1]]
        color = piece.color
        chosen_piece = get_choice

        case chosen_piece
          when "n"
            piece = Chess::Knight.new(color)
          when "r"
            piece = Chess::Rook.new(color)
          when "b"
            piece = Chess::Bishop.new(color)
          when "q"
            piece = Chess::Queen.new(color)
        end

        board[pos[0]][pos[1]] = piece
      end

      def self.get_choice
        puts "Promote pawn to:"
        puts "N for Knight"
        puts "R for Rook"
        puts "B for Bishop"
        puts "Q for Queen"

        choice = gets[0].downcase
        return choice if %w[n r b q].include?(choice)

        puts "Inalid choice. Try again."
        get_choice
      end
    end

    module Castling
      def self.castling(input, board, current_player)
        @board = board
        @current_player = current_player
        @side = parse_input(input)

        castleable?
      end

      def self.parse_input(input)
        input == '0-0' ? :king : :queen
      end

      def self.castleable?
        @side == :king ? verify_kingside : verify_queenside
      end

      def self.verify_kingside
        return false if !king_unchecked_and_first_move?

        # King side rooks must not have moved
        if @current_player == :white
          return false unless (@board[0][7].is_a?(Rook) && @board[0][7].first_move)
        end

        if @current_player == :black
          return false unless (@board[7][7].is_a?(Rook) && @board[7][7].first_move)
        end

        # Path must be empty and not cause check
        valid_path? ? castle : false
      end

      def self.verify_queenside
        return false if !king_unchecked_and_first_move?

        # Queen side rooks must not have moved
        if @current_player == :white
          return false unless (@board[0][0].is_a?(Rook) && @board[0][0].first_move)
        end

        if @current_player == :black
          return false unless (@board[7][0].is_a?(Rook) && @board[7][0].first_move)
        end

        # Path must be empty and not cause check
        valid_path? ? castle : false
      end

      def self.valid_path?
        # King side
        if @side == :king
          if @current_player == :white
            return false unless !(Game.new.check?([0, 5], @board) && Game.new.check?([0, 6], @board)) && (@board[0][5] == ' ' && @board[0][6] == ' ')
          end

          if @current_player == :black
            return false unless !(Game.new(:black).check?([7, 5], @board) && Game.new(:black).check?([7, 6], @board)) && (@board[7][5] == ' ' && @board[7][6] == ' ')
          end
        end

        # Queen side
        if @side == :queen
          if @current_player == :white
            return false unless !(Game.new.check?([0, 3], @board) && Game.new.check?([0, 2], @board)) && (@board[0][3] == ' ' && @board[0][2] == ' ' && @board[0][1] == ' ')
          end

          if @current_player == :black
            return false unless !(Game.new(:black).check?([7, 3], @board) && Game.new(:black).check?([7, 2], @board)) && (@board[7][3] == ' ' && @board[7][2] == ' ' && @board[7][1] == ' ')
          end
        end

        true
      end

      def self.castle
        # King Side Castle
        if @side == :king
          if @current_player == :white
            # Move king
            @board[0][6] = @board[0][4]
            @board[0][4] = ' '

            # Move Rook
            @board[0][5] = @board[0][7]
            @board[0][7] = ' '
          end

          if @current_player == :black
            # Move king
            @board[7][6] = @board[7][4]
            @board[7][4] = ' '

            # Move Rook
            @board[7][5] = @board[7][7]
            @board[7][7] = ' '
          end
        end

        # Queen Side Castle
        if @side == :queen
          if @current_player == :white
            # Move king
            @board[0][2] = @board[0][4]
            @board[0][4] = ' '

            # Move Rook
            @board[0][3] = @board[0][0]
            @board[0][0] = ' '
          end

          if @current_player == :black
            # Move king
            @board[7][2] = @board[7][4]
            @board[7][4] = ' '

            # Move Rook
            @board[7][3] = @board[7][0]
            @board[7][0] = ' '
          end
        end

        true
      end

      def self.king_unchecked_and_first_move?
        # king must not be in check
        return false if Game.new.check?(Game.new.find_king_position(@current_player, @board))

        # king must not have moved
        if @current_player == :white
          return false unless (@board[0][4].is_a?(King) && @board[0][4].first_move)
        end

        if @current_player == :black
          return false unless (@board[7][4].is_a?(King) && @board[7][4].first_move)
        end

        true
      end
    end
  end
end
