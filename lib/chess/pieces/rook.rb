require_relative '../piece'

module Chess
  class Rook < Piece
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

        # Stop loop if out of bounds
        break if !current_rank.between?(0, 7) && !current_file.between?(0, 7)
      end

      # Make sure path is straight
      if @start_rank == @end_rank || @end_file == @start_file
        moved if @first_move == true
        return true
      end
    end

    private

    def moved
      @first_move = false
    end

    def icon_for(color)
      color == :white ? '♖' : '♜'
    end
  end
end
