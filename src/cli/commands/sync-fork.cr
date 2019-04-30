class Commands::SyncFork < Admiral::Command
  define_argument repo
  define_help

  def run
    if %w(brew core cask).includes?(arguments.repo)
      sync_fork(arguments.repo)
    else
      puts "Supported repos are 'brew', 'core' or 'cask'."
    end
  end

  def sync_fork(repo)
    if base_path = Commands::Config.retrieve_value("repo_base_path")
      repo_dir = "#{base_path}/osc/dev-homebrew/#{repo}"
    else
      puts "Run `issyl0 config repo_base_path <value>` then try again."
      exit(1)
    end

    puts "Stashing local changes..."
    stash_local_changes = Process.run("git", ["stash"], chdir: repo_dir)

    puts "Checking out master..."
    checkout_master = Process.run("git", ["checkout", "master"], chdir: repo_dir)

    puts "Fetching the upstream master..."
    fetch_upstream = Process.run("git", ["fetch", "upstream"], chdir: repo_dir)

    puts "Merging upstream into origin..."
    merge_upstream_master = Process.run("git", ["merge", "upstream/master"], chdir: repo_dir)

    puts "Pushing to GitHub..."
    push_origin_master = Process.run("git", ["push", "origin", "master"], chdir: repo_dir)
  end
end
