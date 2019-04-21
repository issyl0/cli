require "yaml"

class Commands::Config < Admiral::Command
  define_argument option
  define_argument value

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
    config_file = "#{ENV["HOME"]}/issyl0-config.yml"
    File.write(config_file, "#{option}: #{value}\n", mode: "a")
  end
end
