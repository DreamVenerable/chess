require_relative '../piece'

module Chess
  class Knight < Piece

    def valid_move?(start_pos, end_pos, board)
      super
      move_difference = [(@end_rank - @start_rank).abs, (@end_file - @start_file).abs]

      # Basic move
      if [[1, 2], [2, 1]].include?(move_difference)
        return true if board[@end_rank][@end_file] == ' ' || board[@end_rank][@end_file].color != @color
      end
    end

    private

    def icon_for(color)
      color == :white ? '♘' : '♞'
    end
  end
end
