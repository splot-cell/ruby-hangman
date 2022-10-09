# frozen_string_literal: true

require_relative "./console_formatting.rb"

module HangmanText
  include ConsoleFormatting

  def remaining_guesses_msg
    if incorrect_guesses_left == 1
      return red("Think hard, you only have 1 incorrect guess left!")
    end
    "You have #{incorrect_guesses_left} incorrect guesses remaining!"
  end

  def current_guess_msg
    "Letters guessed: " \
      "#{guessed_letters.map {|e| color_letter(e) } .join(' ')}" \
      "\n#{guess_progress}\n\n"
  end

  def color_letter(letter)
    target_word.include?(letter) ? green(letter) : red(letter)
  end

  def out_of_guesses_msg
    red("You ran out of guesses! The correct answer was #{cyan(target_word)}")
  end

  def solved_msg
    bold("#{cyan(target_word)}#{blue(' is correct! Well done!')}")
  end

  def new_load_msg
    "If you'd like to start a new game, press [1]. If you'd like to load a saved game, press [2]: "
  end

  def save_game_msg
    green("Game saving...")
  end

  def load_game_msg
    green("Loading game...\n\n")
  end

  def letter_prompt_msg
    "Guess a letter: "
  end

  def error_already_guessed
    red("You have already guessed that letter!\n\n")
  end

  def error_unrecognized_guess
    red("Please enter one letter, or 'save' to save your game!\n\n")
  end

  def error_unrecognized_selection
    red("\nSelection not recognized.\n")
  end
end
