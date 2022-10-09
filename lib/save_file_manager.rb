# frozen_string_literal: true

require "yaml"

class SaveFileManager
  @saves_dir = "./saves/"

  def initialize
    Dir.mkdir(self.class.saves_dir) unless Dir.exist?(self.class.saves_dir)
  end

  def save(obj)
    save_file = File.open(generate_filename, "w") do
      |file| file.puts(YAML.dump(obj))
    end
  end

  def self.saves_dir
    @saves_dir
  end

  def filename_adjectives
    %w[sleepy jumpy feisty humble proud]
  end

  def filename_nouns
    %w[panda octopus lizard kangeroo lemur]
  end

  def generate_filename
  "#{self.class.saves_dir}" \
    "#{filename_adjectives.sample}_#{filename_nouns.sample}.yaml"
  end

  def load
    return no_saves if file_list.empty?

    YAML.load(File.read("#{self.class.saves_dir}#{file_list[select_file]}"))
  end

  def no_saves
    puts no_save_files_msg
    {}
  end

  def select_file
    puts file_list_msg
    selection = gets.chomp
    return selection.to_i if selection.match(/^[0-9]$/) &&
           selection.to_i < file_list.length
    puts "Selection not recognized\n\n"
    select_file
  end

  def file_list
    Dir.children(self.class.saves_dir)
  end

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
end
