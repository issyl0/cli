package cfg

import (
	"fmt"
	"os"
)

// CreateConfigFileIfNotExist creates (or not) $HOME/issyl0-config.yml.
func CreateConfigFileIfNotExist(configFile string) {
	var _, err = os.Stat(configFile)
	if os.IsNotExist(err) {
		var file, err = os.Create(configFile)
		if err != nil {
			return
		}
		file.Close()
	}
}

// WriteDataToConfigFile writes the passed in data to $HOME/issyl0-config.yml.
func WriteDataToConfigFile(configFile string, cfgOption string, cfgValue string) {
	var file, err = os.OpenFile(configFile, os.O_APPEND|os.O_RDWR, 0644)
	if err != nil {
		return
	}
	defer file.Close()

	cfgLine := fmt.Sprintf("%s: %s\n", cfgOption, cfgValue)

	_, err = file.WriteString(cfgLine)
	if err != nil {
		fmt.Println("Something went wrong...")
	}

	err = file.Sync()
	if err != nil {
		return
	}
}
