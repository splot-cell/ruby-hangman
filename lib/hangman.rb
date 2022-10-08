# frozen_string_literal: true

class Hangman
  attr_accessor :target_word, :guessed_letters, :incorrect_guesses_left

  def initialize(target_word)
    @target_word = target_word
    @incorrect_guesses_left = 10
    @guessed_letters = []
  end

  def run
    play_turn
  end

  def play_turn
    puts remaining_guesses_msg
    puts current_guess_msg
    guessed_letters.push(player_guess)
    play_turn
  end

  def remaining_guesses_msg
    "You have #{incorrect_guesses_left} incorrect guesses remaining!"
  end

  def current_guess_msg
    puts "Letters guessed: #{guessed_letters.join(' ')}"
    puts guess_progress
  end

  def guess_progress
    progress = []
    target_word.split("").each do |letter|
      guessed_letters.include?(letter) ? progress.push(letter) : progress.push("_")
    end
    progress.join
  end

  def player_guess
    print "Guess a letter: "
    guess = gets.chomp[0]
    if guess.match(/[a-z]/i)
      return guess unless guessed_letters.include?(guess)
      puts "You have already guessed that letter!"
    else
      puts "Please ensure the first character is an identifiable letter!"
    end
    player_guess
  end
end
