# frozen_string_literal: true

require_relative "./save_file_manager.rb"
require_relative "./hangman_text.rb"

class Hangman
  include HangmanText
  attr_accessor :target_word, :guessed_letters, :incorrect_guesses_left

  def initialize
    @target_word = random_word
    @incorrect_guesses_left = 10
    @guessed_letters = []
    load_game if new_or_load_game == "2"
  end

  def run
    puts play_turn
  end

  private

  def random_word
    word = File.readlines("./google-10000-english-no-swears.txt").sample.chomp
    word.length.between?(5, 12) ? word : random_word
  end

  def solved?
    guess_progress == target_word
  end

  def play_turn
    return out_of_guesses_msg if incorrect_guesses_left.zero?
    puts remaining_guesses_msg
    puts current_guess_msg
    if player_guess.match(/save/i)
      return if save_game == 0
    end
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
    print letter_prompt_msg
    guess = gets.chomp
    if guess.to_s.match(/\A[a-z]\Z/i)
      return evaluate_guess(guess).to_s unless guessed_letters.include?(guess)
      puts error_already_guessed
    elsif guess.to_s.match(/save/i)
      return guess
    else
      puts error_unrecognized_guess
    end
    player_guess
  end

  def save_game
    puts save_game_msg
    SaveFileManager.new.save(serialize)
  end

  def load_game
    puts load_game_msg
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
    puts error_unrecognized_selection
    new_or_load_game
  end
end
