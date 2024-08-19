require_relative '../piece'

module Chess
  class Queen < Piece
    def valid_move?(start_pos, end_pos, board)
      return false unless super

      # Make sure path is empty
      rank_step = (@end_rank <=> @start_rank)
      file_step = (@end_file <=> @start_file)

      current_rank, current_file = @start_rank + rank_step, @start_file + file_step

      while [current_rank, current_file] != [@end_rank, @end_file]
        return false unless board[current_rank][current_file] == ' '
        current_rank += rank_step
        current_file += file_step
      end

      # Make sure path is straight or diagonal
      displacement = [(@end_rank - @start_rank).abs, (@end_file - @start_file).abs]
      return true if @start_rank == @end_rank || @end_file == @start_file || displacement[0] == displacement[1]
    end

    private

    def icon_for(color)
      color == :white ? '♕' : '♛'
    end
  end
end
