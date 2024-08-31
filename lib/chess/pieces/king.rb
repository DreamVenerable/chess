require_relative '../piece'

module Chess
  class King < Piece
    def valid_move?(start_pos, end_pos, board)
      return false unless super

      # Makes sure path is 1 square away
      valid_displacements = [[1, 1], [1, 0], [0, 1]]
      displacement = [(@end_rank - @start_rank).abs, (@end_file - @start_file).abs]
      if valid_displacements.include?(displacement)
        moved if @first_move == true
        return true
      end
    end

    private

    def moved
      @first_move = false
    end

    def icon_for(color)
      color == :white ? '♔' : '♚'
    end
  end
end
