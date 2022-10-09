# frozen_string_literal: true

require_relative "./console_formatting.rb"

module SaveFileManagerText
  include ConsoleFormatting

  def no_save_files_msg
    "No savefiles detected, starting new game..."
  end

  def file_list_msg
    msg = ["Enter a number to select a file from the filelist:\n"]
    file_list.each_with_index do |file, index|
      msg.push("[#{blue(index)}]\t#{file}")
    end
    msg.join("\n")
  end

  def game_saved_msg(filename)
    "Your game was saved as #{green(filename)}"
  end

  def error_too_many_files
    red("Error: too many save files!")
  end

  def error_unrecognized_selection
    red("Selection not recognized\n\n")
  end
end
