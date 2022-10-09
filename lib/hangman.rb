# frozen_string_literal: true

class Hangman
  attr_accessor :target_word, :guessed_letters, :incorrect_guesses_left

  def initialize(target_word)
    @target_word = target_word
    @incorrect_guesses_left = 10
    @guessed_letters = []
  end

  def run
    puts play_turn
  end

  private

  def solved?
    guess_progress == target_word
  end

  def play_turn
    return out_of_guesses_msg if incorrect_guesses_left.zero?
    puts remaining_guesses_msg
    puts current_guess_msg
    evaluate_guess(player_guess)
    return solved_msg if solved?
    play_turn
  end

  def evaluate_guess(letter)
    @incorrect_guesses_left -= 1 unless target_word.include?(letter)
    guessed_letters.push(letter)
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
    guess = gets.chomp
    if guess.to_s.match(/\A[a-z]\Z/i)
      return guess unless guessed_letters.include?(guess)
      puts "You have already guessed that letter!"
    else
      puts "Please enter one letter, or 'save' to save your game!"
    end
    player_guess
  end

  def remaining_guesses_msg
    "You have #{incorrect_guesses_left} incorrect guesses remaining!"
  end

  def current_guess_msg
    puts "Letters guessed: #{guessed_letters.join(' ')}"
    puts guess_progress
  end

  def out_of_guesses_msg
    "You ran out of guesses! The correct answer was #{target_word}."
  end

  def solved_msg
    "#{target_word} is correct! Well done!"
  end
end
