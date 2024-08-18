require_relative '../piece'

module Chess
  class Knight < Piece

    def valid_move?(start_pos, end_pos, board)
      super
      knight_moves = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-1, 2], [-2, 1]]
      move_difference = [@end_rank - @start_rank, @end_file - @start_file]

      # Basic move
      if knight_moves.include?(move_difference)
        return true if board[@end_rank][@end_file] == ' ' || board[@end_rank][@end_file].color != @color
      end
    end

    private

    def icon_for(color)
      color == :white ? '♘' : '♞'
    end
  end
end
