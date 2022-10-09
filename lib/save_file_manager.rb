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

  def generate_filename
  "#{self.class.saves_dir}uniqfilname.yaml"
  end
end
