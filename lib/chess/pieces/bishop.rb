require_relative '../piece'

module Chess
  class Bishop < Piece
    def valid_move?(start_pos, end_pos, board)
      super

      displacement = [(@end_rank - @start_rank).abs, (@end_file - @start_file).abs]

      # Make sure path is diagonal
      return false unless displacement[0] == displacement[1]

      # Make sure path is empty
      rank_step = (@end_rank <=> @start_rank)
      file_step = (@end_file <=> @start_file)

      current_rank, current_file = @start_rank + rank_step, @start_file + file_step

      while [current_rank, current_file] != [@end_rank, @end_file]
        return false unless board[current_rank][current_file] == ' '
        current_rank += rank_step
        current_file += file_step
      end

      board[@end_rank][@end_file] == ' ' || board[@end_rank][@end_file].color != @color
    end

    private

    def icon_for(color)
      color == :white ? '♗' : '♝'
    end
  end
end
