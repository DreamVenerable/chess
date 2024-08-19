require_relative '../piece'

module Chess
  class Knight < Piece

    def valid_move?(start_pos, end_pos, board)
      return false unless super

      # Makes sure path is L shape
      displacement = [(@end_rank - @start_rank).abs, (@end_file - @start_file).abs]
      return true if [[1, 2], [2, 1]].include?(displacement)
    end

    private

    def icon_for(color)
      color == :white ? '♘' : '♞'
    end
  end
end
