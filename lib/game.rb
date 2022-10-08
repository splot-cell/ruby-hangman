# frozen_string_literal: true

require_relative "./hangman.rb"

def random_word
  word = File.readlines("./google-10000-english-no-swears.txt").sample.chomp
  word.length.between?(5, 12) ? word : random_word
end

game = Hangman.new(random_word).run
