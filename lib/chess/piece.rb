module Chess
  class Piece
    attr_reader :color, :icon

    def initialize(color)
      @color = color
      @icon = icon_for(color)
    end

    def icon_for(color)
      raise NotImplementedError, "Error"
    end
  end
end
