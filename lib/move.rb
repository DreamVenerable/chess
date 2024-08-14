class Move
  def initialize
    get_move
  end

  def get_move
    move = gets.chomp
    parse_move(move)
  end

  def parse_move(move)
    piece = move[0]
    destination = move[-2..-1]
    capture = move.include?('x')
    promotion = move.include?('=')

    [piece, destination, capture, promotion]
  end
end
