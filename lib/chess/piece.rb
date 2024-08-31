module Chess
  class Piece
    attr_reader :color, :icon, :first_move

    def initialize(color)
      @color = color
      @icon = icon_for(color)
      @first_move = true
    end

    def valid_move?(start_pos, end_pos, board)
      @start_rank, @start_file = start_pos
      @end_rank, @end_file = end_pos

      # End position should be empty or not have an ally piece
      (board[@end_rank][@end_file] == ' ') || (board[@end_rank][@end_file].color != @color)
    end


    def icon_for(color)
      raise NotImplementedError, "Error"
    end
  end
end
