module Chess
  module NotationParser
    def self.parse_move(move)
      piece = move[0]
      destination = move[-2..-1]
      capture = move.include?('x')
      promotion = move.include?('=')

      [piece, destination, capture, promotion]
    end
  end
end
