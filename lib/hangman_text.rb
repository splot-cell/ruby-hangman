# frozen_string_literal: true

module HangmanText
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

  def save_game_msg
    "Game saving..."
  end

  def load_game_msg
    "Loading game...\n\n"
  end

  def letter_prompt_msg
    "Guess a letter: "
  end

  def error_already_guessed
    "You have already guessed that letter!\n\n"
  end

  def error_unrecognized_guess
    "Please enter one letter, or 'save' to save your game!\n\n"
  end

  def error_unrecognized_selection
    "\nSelection not recognized.\n"
  end
end
