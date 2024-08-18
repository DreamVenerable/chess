module Chess
  module NotationParser
    def self.parse_move(move)
      # Ex. ng1f3
      # piece = move[0] # n = Knight
      start_pos = convert_to_index(move[1..2]) # g1 = where the piece is located
      dest_pos = convert_to_index(move[3..4]) # f3 = destination of piece

      [start_pos, dest_pos]
    end

    def self.convert_to_index(destination)
      file = destination[0].ord - 'a'.ord
      rank = destination[1].to_i - 1
      [rank, file]
    end
  end
end
