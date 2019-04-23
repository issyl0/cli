require "./cli/*"

begin
  Issyl0::CLI::Main.run if ARGV[1]
rescue IndexError
  Issyl0::CLI::Main.run "--help"
end
