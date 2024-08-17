module Chess
  class ChessBoard
    attr_accessor :board

    def initialize
      @board = Array.new(8) {Array.new(8, ' ')}
      setup_pieces
    end


    def display
      b = @board
      puts board =  <<~BOARD
          a   b   c   d   e   f   g   h
        +---+---+---+---+---+---+---+---+
      8 | #{b[7][0]} | #{b[7][1]} | #{b[7][2]} | #{b[7][3]} | #{b[7][4]} | #{b[7][5]} | #{b[7][6]} | #{b[7][7]} | 8
        +---+---+---+---+---+---+---+---+
      7 | #{b[6][0]} | #{b[6][1]} | #{b[6][2]} | #{b[6][3]} | #{b[6][4]} | #{b[6][5]} | #{b[6][6]} | #{b[6][7]} | 7
        +---+---+---+---+---+---+---+---+
      6 | #{b[5][0]} | #{b[5][1]} | #{b[5][2]} | #{b[5][3]} | #{b[5][4]} | #{b[5][5]} | #{b[5][6]} | #{b[5][7]} | 6
        +---+---+---+---+---+---+---+---+
      5 | #{b[4][0]} | #{b[4][1]} | #{b[4][2]} | #{b[4][3]} | #{b[4][4]} | #{b[4][5]} | #{b[4][6]} | #{b[4][7]} | 5
        +---+---+---+---+---+---+---+---+
      4 | #{b[3][0]} | #{b[3][1]} | #{b[3][2]} | #{b[3][3]} | #{b[3][4]} | #{b[3][5]} | #{b[3][6]} | #{b[3][7]} | 4
        +---+---+---+---+---+---+---+---+
      3 | #{b[2][0]} | #{b[2][1]} | #{b[2][2]} | #{b[2][3]} | #{b[2][4]} | #{b[2][5]} | #{b[2][6]} | #{b[2][7]} | 3
        +---+---+---+---+---+---+---+---+
      2 | #{b[1][0]} | #{b[1][1]} | #{b[1][2]} | #{b[1][3]} | #{b[1][4]} | #{b[1][5]} | #{b[1][6]} | #{b[1][7]} | 2
        +---+---+---+---+---+---+---+---+
      1 | #{b[0][0]} | #{b[0][1]} | #{b[0][2]} | #{b[0][3]} | #{b[0][4]} | #{b[0][5]} | #{b[0][6]} | #{b[0][7]} | 1
        +---+---+---+---+---+---+---+---+
          a   b   c   d   e   f   g   h
      BOARD
    end

    def move_piece()

    end

    private

    def setup_pieces
      setup_pawns
      setup_major_pieces
    end

    def setup_pawns
      # White Pawns
      (0..7).each do |file|
        @board[1][file] = Chess::Pawn.new(:white).icon
      end
      # Black Pawns
      (0..7).each do |file|
        @board[6][file] = Chess::Pawn.new(:black).icon
      end
    end

    def setup_major_pieces
      setup_major_pieces_for(:white, 0)
      setup_major_pieces_for(:black, 7)
    end

    def setup_major_pieces_for(color, rank)
      @board[rank][0] = Chess::Rook.new(color).icon
      @board[rank][1] = Chess::Knight.new(color).icon
      @board[rank][2] = Chess::Bishop.new(color).icon
      @board[rank][3] = Chess::Queen.new(color).icon
      @board[rank][4] = Chess::King.new(color).icon
      @board[rank][5] = Chess::Bishop.new(color).icon
      @board[rank][6] = Chess::Knight.new(color).icon
      @board[rank][7] = Chess::Rook.new(color).icon
    end
  end
end
