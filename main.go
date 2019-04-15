package main

import (
	"fmt"
	"log"
	"os"

	cfg "github.com/issyl0/cli/cfg"
	syncFork "github.com/issyl0/cli/sync-fork"

	"github.com/urfave/cli"
)

func main() {
	var repo string
	var cfgOption string
	var cfgValue string

	app := cli.NewApp()
	app.Name = "issyl0"
	app.Usage = "CLI for computery things issyl0 does"

	app.Commands = []cli.Command{
		{
			Name:  "config",
			Usage: "Configure the CLI (email address, homebrew repo dir, ...)",
			Action: func(c *cli.Context) error {
				if c.NArg() > 1 {
					cfgOption = c.Args().Get(0)
					cfgValue = c.Args().Get(1)
				} else {
					fmt.Println("You must specify a config option and a value for that option.")
					os.Exit(1)
				}

				if cfgOption == "email" || cfgOption == "personal_repo_dir" {
					configFile := fmt.Sprintf("%s/issyl0-config.yml", os.Getenv("HOME"))
					cfg.CreateConfigFileIfNotExist(configFile)
					cfg.WriteDataToConfigFile(configFile, cfgOption, cfgValue)
				} else {
					fmt.Println("Available config options are 'email' and 'personal_repo_dir'.")
					os.Exit(1)
				}

				return nil

			},
		},
		{
			Name:  "sync-fork",
			Usage: "Update and sync forks, eg homebrew/brew, homebrew/core or homebrew/cask.",
			Action: func(c *cli.Context) error {
				if c.NArg() > 0 {
					repo = c.Args().Get(0)
				} else {
					fmt.Println("You must specify a repo to sync.")
					os.Exit(1)
				}

				if repo == "brew" || repo == "core" || repo == "cask" {
					syncFork.Homebrew(repo)
				} else {
					fmt.Println("Repos other than Homebrew ones aren't implemented yet.")
					os.Exit(1)
				}

				return nil
			},
		},
	}

	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err)
	}
}
