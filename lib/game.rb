# frozen_string_literal: true

require_relative "./hangman.rb"

def random_word
  word_list = File.readlines("./google-10000-english-no-swears.txt").sample
end

game = Hangman.new(random_word)
