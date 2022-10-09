# frozen_string_literal: true

module SaveFileManagerText
  def no_save_files_msg
    "No savefiles detected, starting new game..."
  end

  def file_list_msg
    msg = ["Enter a number to select a file from the filelist:\n"]
    file_list.each_with_index do |file, index|
      msg.push("[#{index}]\t#{file}")
    end
    msg.join("\n")
  end

  def game_saved_msg
    "Your game was saved as #{filename}"
  end

  def error_too_many_files
    "Error: too many save files!"
  end

  def error_unrecognized_selection
    "Selection not recognized\n\n"
  end
end
