#!/usr/bin/env ruby
require_relative '../lib/chess/game.rb'
require_relative '../lib/chess/board.rb'
require_relative '../lib/chess/special_moves.rb'
require_relative '../lib/chess/notation_parser.rb'
require_relative '../lib/chess/piece.rb'

Dir[File.join(__dir__, '../lib/chess/pieces/*.rb')].each { |file| require_relative file}


game = Chess::Game.new
game.play
