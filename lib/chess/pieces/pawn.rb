require_relative '../piece'

module Chess
  class Pawn < Piece
    def valid_move?(start_pos, end_pos, board)
      start_rank, start_file = start_pos
      end_rank, end_file = end_pos

      # Determine direction by color
      direction = color == :white ? 1 : -1

      # Basic move: One square forward
      if start_file == end_file
        return true if end_rank == start_rank + direction && board[end_rank][end_file] == ' '

        # Initial move: Two squares forward
        if (color == :white && start_rank == 1) || (color == :black && start_rank == 6)
          return true if end_rank == start_rank + (2 * direction) && board[end_rank][end_file] == ' ' && board[start_rank + direction][start_file] == ' '
        end
      end

      # Capture move: diagonal by one square
      if (end_file - start_file).abs == 1 && end_rank == start_rank + direction
        return true if board[end_rank][end_file] != ' ' && board[end_rank][end_file].color != color
      end
    end

    private

    def icon_for(color)
      color == :white ? '♙' : '♟︎'
    end
  end
end
