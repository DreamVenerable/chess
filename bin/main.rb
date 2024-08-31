#!/usr/bin/env ruby
require_relative '../lib/chess/game.rb'
require_relative '../lib/chess/board.rb'
require_relative '../lib/chess/special_moves.rb'
require_relative '../lib/chess/notation_parser.rb'
require_relative '../lib/chess/piece.rb'

Dir[File.join(__dir__, '../lib/chess/pieces/*.rb')].each { |file| require_relative file}


def choice
  begin
    letter = gets.downcase.match(/^[ln]{1}$/)[0]
  rescue StandardError
    puts 'Wrong input! N/L'
    retry
  end
  choose_game(letter)
end

def choose_game(choice)
  case choice
  when 'n'
    Chess::Game.new.play
  when 'l'
    choose_file
  end
end

def choose_file
  puts "Type your game number: (e.g., Type 7 for Game7) or 'q' to quit"
  print_files

  begin
    input = gets.chomp.downcase

    if input == 'q'
      puts "Quitting the game."
      exit
    elsif input.match?(/^[0-9]$/)
      num = input.to_i
      load_game(num)
    else
      raise "Invalid input"
    end
  rescue StandardError
    puts 'Wrong input, (0-9) or (q) to quit only!'
    retry
  end
end

def print_files
  Dir["./game_files/*"].each { |file| puts puts "#{File.basename(file)}" if File.file?(file) }
end

def load_game(i)
  game_file = File.read("./game_files/Game#{i}.marshal")
  data = Marshal.load(game_file)
  Chess::Game.new(data[0], data[1]).play
end

puts "Would you like load a saved game or a play a new game?"
puts "[Type 'N' for New Game - Type 'L' to load game]"
choice
