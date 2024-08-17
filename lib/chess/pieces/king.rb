require_relative '../piece'

module Chess
  class King < Piece
    private

    def icon_for(color)
      color == :white ? '♔' : '♚'
    end
  end
end
