module Chess
  module SpecialMoves
    module Promotion
      def self.promote?(pos, board)
        piece = board[pos[0]][pos[1]]
        return true if piece.is_a?(Pawn) && (piece.color == :white && pos[0] == 7) || (piece.color == :black && pos[0] == 0)
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
  end
end
