require "yaml"

class Commands::Config < Admiral::Command
  define_argument option, required: true
  define_argument value, required: true
  define_help

  CONFIG_FILE = "#{ENV["HOME"]}/issyl0-config.yml"

  def run
    if %w(email repo_base_path).includes?(arguments.option)
      if !self.class.retrieve_value(arguments.option)
        write_data_to_config_file(arguments.option, arguments.value)
      else
        puts "Config option #{arguments.option} already exists. Edit #{CONFIG_FILE} to change its value."
      end
    else
      puts "Available config options are `email` or `repo_base_path`."
    end
  end

  def write_data_to_config_file(option, value)
    File.write(CONFIG_FILE, "#{option}: #{value}\n", mode: "a")
  end

  def self.retrieve_value(option)
    if File.exists?(CONFIG_FILE)
      begin
        YAML.parse(File.read(CONFIG_FILE))[option].as_s
      rescue KeyError
        return false
      end
    else
      return false
    end
  end
end
