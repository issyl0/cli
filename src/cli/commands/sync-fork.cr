class Commands::SyncFork < Admiral::Command
  define_argument repo

  def run
    if %w(brew core cask).includes?(arguments.repo)
      sync_fork(arguments.repo)
    else
      puts "Supported repos are 'brew', 'core' or 'cask'."
    end
  end

  def sync_fork(repo)
    repo_dir = "#{Commands::Config.retrieve_value("repo_base_path")}/osc/dev-homebrew/#{repo}"

    checkout_master = Process.run("git", ["checkout", "master"], chdir: repo_dir)

    fetch_upstream = Process.run("git", ["fetch", "upstream"], chdir: repo_dir)

    merge_upstream_master = Process.run("git", ["merge", "upstream/master"], chdir: repo_dir)

    push_origin_master = Process.run("git", ["push", "origin", "master"], chdir: repo_dir)
  end
end
