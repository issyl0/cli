require "yaml"

class Commands::Config < Admiral::Command
  define_argument option
  define_argument value

  CONFIG_FILE = "#{ENV["HOME"]}/issyl0-config.yml"

  def run
    if arguments.value
      if %w(email repo_base_path).includes?(arguments.option)
        write_data_to_config_file(arguments.option, arguments.value)
      else
        puts "Available config options are `email` or `repo_base_path`."
      end
    else
      puts "You must specify a value for your config option."
    end
  end

  def write_data_to_config_file(option, value)
    File.write(CONFIG_FILE, "#{option}: #{value}\n", mode: "a")
  end

  def self.retrieve_value(option)
    if File.exists?(CONFIG_FILE)
      YAML.parse(File.read(CONFIG_FILE))[option].as_s
    else
      puts "Create a config file with some data first. Run `issyl0 config`."
    end
  end
end
