package syncfork

import (
	"fmt"
	"os/exec"
)

// Homebrew runs git commands to update `repo` where it's one of
// `brew`, `core`, or `cask`.
func Homebrew(repo string) error {
	dir := fmt.Sprintf("/Users/issyl0/repos/osc/dev-homebrew/%s", repo)

	master := exec.Command("git", "checkout", "master")
	master.Dir = dir
	_, err := master.Output()

	if err != nil {
		fmt.Printf("Could not run `git checkout master`, error %v", err.Error())
	}

	fetch := exec.Command("git", "fetch", "upstream")
	fetch.Dir = dir
	_, err = fetch.Output()

	if err != nil {
		fmt.Printf("Could not run `git fetch upstream`, error %v", err.Error())
	}

	merge := exec.Command("git", "merge", "upstream/master")
	merge.Dir = dir
	_, err = merge.Output()

	if err != nil {
		fmt.Printf("Could not run `git merge upstream/master`, error %v", err.Error())
	}

	push := exec.Command("git", "push", "origin", "master")
	push.Dir = dir
	_, err = push.Output()

	if err != nil {
		fmt.Printf("Could not run `git push origin master`, error %v", err.Error())
	}

	return nil
}
