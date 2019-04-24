require "admiral"
require "../cli"
require "./commands/*"

class Issyl0::CLI::Main < Admiral::Command
  define_version "1.0.0"
  define_help

  register_sub_command "config", Commands::Config
  register_sub_command "sync-fork", Commands::SyncFork
  register_sub_command "link", Commands::Links

  def Issyl0::CLI.run(*args, **named_args)
    Issyl0::CLI::Main.run(*args, **named_args)
  end
end
