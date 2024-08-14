#!/usr/bin/env ruby
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/move'
require_relative '../lib/notation_parser.rb'


game = Chess::Game.new
game.play
