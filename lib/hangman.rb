# frozen_string_literal: true

class Hangman
  attr_accessor :target_word, :guessed_letters
  def initialize(target_word)
    @target_word = target_word
  end
end
