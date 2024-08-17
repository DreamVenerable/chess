module Chess
  module NotationParser
    def self.parse_move(move)
      piece = move[0]
      destination = move[-2..-1]
      capture = move.include?('x')
      promotion = move.include?('=')

      [piece, destination, capture, promotion]
    end

    def convert_to_index(destination)
      file = destination[0].ord - 'a'.ord
      rank = destination[1] - 1
      [rank, file]
    end
  end
end
