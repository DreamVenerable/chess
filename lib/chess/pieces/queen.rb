require_relative '../piece'

module Chess
  class Queen < Piece
    private

    def icon_for(color)
      color == :white ? '♕' : '♛'
    end
  end
end
