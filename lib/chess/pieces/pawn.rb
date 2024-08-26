require_relative '../piece'

module Chess
  class Pawn < Piece

    def valid_move?(start_pos, end_pos, board)
      return false unless super

      # Determine direction by color
      @direction = @color == :white ? 1 : -1

      # Basic move: One square forward
      return true if (@start_file == @end_file) && (@end_rank == @start_rank + @direction) && (board[@end_rank][@end_file] == ' ')

      # Initial move: Two squares forward
      if (@color == :white && @start_rank == 1) || (@color == :black && @start_rank == 6)
        return true if (@end_rank == @start_rank + (2 * @direction)) && (board[@start_rank + @direction][@start_file] == ' ') && (@start_file == @end_file) && (board[@end_rank][@end_file] == ' ')
      end

      # Capture move: diagonal by one square
      if ((@end_file - @start_file).abs == 1) && (@end_rank == @start_rank + @direction) && (board[@end_rank][@end_file] != ' ')
        p "diff:"
        p (@end_file - @start_file).abs
        return true
      end
    end

    private

    def icon_for(color)
      color == :white ? '♙' : '♟︎'
    end
  end
end
