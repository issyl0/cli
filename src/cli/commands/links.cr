class Commands::Links < Admiral::Command
  define_argument command, required: true
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
    if destination_exists? && %w(show open).includes?(arguments.command)
        # MacOS: Open the URL in a web browser.
        Process.run("open", [@url]) if arguments.command == "open"
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
