module Chess
  class Piece
    attr_reader :color, :icon

    def initialize(color)
      @color = color
      @icon = icon_for(color)
    end

    def valid_move?(start_pos, end_pos, board)
      @start_rank, @start_file = start_pos
      @end_rank, @end_file = end_pos
    end


    def icon_for(color)
      raise NotImplementedError, "Error"
    end
  end
end
