module Chess
  module NotationParser
    def self.parse_move(move)
      # Ex. g1f3
      start_pos = convert_to_index(move[0..1]) # g1 = where the piece is located
      dest_pos = convert_to_index(move[2..3]) # f3 = destination of piece

      [start_pos, dest_pos]
    end

    def self.convert_to_index(destination)
      file = destination[0].ord - 'a'.ord
      rank = destination[1].to_i - 1
      [rank, file]
    end
  end
end
