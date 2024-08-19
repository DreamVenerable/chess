require_relative '../piece'

module Chess
  class Knight < Piece

    def valid_move?(start_pos, end_pos, board)
      super
      displacement = [(@end_rank - @start_rank).abs, (@end_file - @start_file).abs]

      # Basic move
      if [[1, 2], [2, 1]].include?(displacement)
        return true if board[@end_rank][@end_file] == ' ' || board[@end_rank][@end_file].color != @color
      end
    end

    private

    def icon_for(color)
      color == :white ? '♘' : '♞'
    end
  end
end
