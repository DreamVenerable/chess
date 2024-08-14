require_relative 'lib/board'
require_relative 'lib/move'

class Start
  def initialize
    Board.new
    Move.new
  end
end

Start.new
