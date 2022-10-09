# frozen_string_literal: true

require_relative "./save_file_manager.rb"

class Hangman
  attr_accessor :target_word, :guessed_letters, :incorrect_guesses_left

  def initialize(target_word)
    @target_word = target_word
    @incorrect_guesses_left = 10
    @guessed_letters = []
    load_game if new_or_load_game == "2"
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
    return save_game if player_guess.match(/save/i)
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
      return evaluate_guess(guess).to_s unless guessed_letters.include?(guess)
      puts "You have already guessed that letter!\n\n"
    elsif guess.to_s.match(/save/i)
      return guess
    else
      puts "Please enter one letter, or 'save' to save your game!\n\n"
    end
    player_guess
  end

  def save_game
    puts "Game saving..."
    SaveFileManager.new.save(serialize)
  end

  def load_game
    puts "Loading game..."
    unserialize(SaveFileManager.new.load)
  end

  def serialize
    data = {}
    instance_variables.map do |var|
      data[var] = instance_variable_get(var)
    end
    data
  end

  def unserialize(data)
    data.keys.each do |key|
      instance_variable_set(key, data[key])
    end
  end

  def new_or_load_game
    print new_load_msg
    choice = gets.chomp
    return choice if choice.match(/^[12]$/)
    puts "\nSelection not recognized.\n"
    new_or_load_game
  end

  def remaining_guesses_msg
    "You have #{incorrect_guesses_left} incorrect guesses remaining!"
  end

  def current_guess_msg
    "Letters guessed: #{guessed_letters.join(' ')}\n#{guess_progress}\n\n"
  end

  def out_of_guesses_msg
    "You ran out of guesses! The correct answer was #{target_word}."
  end

  def solved_msg
    "#{target_word} is correct! Well done!"
  end

  def new_load_msg
    "If you'd like to start a new game, press [1]. If you'd like to load a saved game, press [2]: "
  end
end
