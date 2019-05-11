class Commands::Links < Admiral::Command
  define_argument command
  define_argument destination
  define_help

  LINKS = [
    {
      "name"        => "plex",
      "description" => "Plex, from home network.",
      "url"         => "http://172.16.0.75:32400"
    },
    {
      "name"        => "concourse",
      "description" => "Concourse, from home network.",
      "url"         => "http://172.16.0.75:8080"
    },
  ]

  @url = ""

  def run
    if arguments.destination && arguments.command && destination_exists? && %w(show open).includes?(arguments.command)
        if arguments.command == "open"
          if %w(procyon).includes?(System.hostname)
            Process.run("open", [@url])
          elsif %w(grus).includes?(System.hostname)
            Process.run("xdg-open", [@url])
          elsif %w(rho sky).includes?(System.hostname)
            puts "These machines don't have web browsers installed."
            exit(1)
          end
        end
        # Print the URL to stdout, for use in `pbcopy` etc.
        puts @url if arguments.command == "show"
    else
      puts "Available links (`issyl0 link show/open <link>`) are:"
      LINKS.each do |link|
        puts "#{link["name"]} \t #{link["url"]} \t #{link["description"]}"
      end
    end
  end

  def destination_exists?
    LINKS.each do |link|
      if link["name"] == arguments.destination
        @url = link["url"]
        return true
      end
    end
  end
end
