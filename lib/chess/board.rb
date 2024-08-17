module Chess
  class ChessBoard
    attr_accessor :board

    def initialize
      @board = Array.new(8) {Array.new(8, ' ')}
      setup_pieces
    end

    def display
      files = ('a'..'h').to_a
      puts "    #{files.join('   ')}"
      puts "  +---" + ("+---" * 7) + "+"

      @board.reverse.each_with_index do |row, i|
        puts "#{8 - i} | #{row.map { |piece| piece_icon(piece) }.join(' | ')} | #{8 - i}"
        puts "  +---" + ("+---" * 7) + "+"
      end

      puts "    #{files.join('   ')}"
    end

    def piece_icon(piece)
      piece == ' ' ? ' ' : piece.icon
    end

    def move_piece(piece, start_pos, dest_pos)
      @board[dest_pos[0]][dest_pos[1]] = @board[start_pos[0]][start_pos[1]]
      @board[start_pos[0]][start_pos[1]] = ' '
    end

    private

    def setup_pieces
      setup_pawns
      setup_major_pieces
    end

    def setup_pawns
      # White Pawns
      (0..7).each do |file|
        @board[1][file] = Chess::Pawn.new(:white)
      end
      # Black Pawns
      (0..7).each do |file|
        @board[6][file] = Chess::Pawn.new(:black)
      end
    end

    def setup_major_pieces
      setup_major_pieces_for(:white, 0)
      setup_major_pieces_for(:black, 7)
    end

    def setup_major_pieces_for(color, rank)
      @board[rank][0] = Chess::Rook.new(color)
      @board[rank][1] = Chess::Knight.new(color)
      @board[rank][2] = Chess::Bishop.new(color)
      @board[rank][3] = Chess::Queen.new(color)
      @board[rank][4] = Chess::King.new(color)
      @board[rank][5] = Chess::Bishop.new(color)
      @board[rank][6] = Chess::Knight.new(color)
      @board[rank][7] = Chess::Rook.new(color)
    end
  end
end
