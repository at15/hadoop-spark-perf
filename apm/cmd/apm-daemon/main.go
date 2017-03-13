package main

import (
	dlog "github.com/dyweb/gommon/log"
	"os"
)

// Logger is the default logger with info level
var Logger = dlog.NewLogger()

// Short name use in util package
var log = Logger.NewEntryWithPkg("apm.daemon")

func getFile(filepath string) (*os.File, error) {
	// FIXME: should not be 777
	return os.OpenFile(filepath, os.O_CREATE|os.O_RDWR|os.O_APPEND, 0777)
}

func main() {
	log.Info("let's daemonlize something!")
	op := "/home/at15/tmp/ayi.out"
	er := "/home/at15/tmp/ayi.err"
	outFile, err := getFile(op)
	if err != nil {
		log.Error(err)
		return
	}
	errFile, err := getFile(er)
	if err != nil {
		log.Error(err)
		return
	}
	procAttr := os.ProcAttr{
		Files: []*os.File {
			os.Stdin,
			outFile,
			errFile,
		},
	}
	args := []string{"Ayi", "web", "static"}
	process, err := os.StartProcess("/home/at15/workspace/bin/Ayi", args, &procAttr)
	if err != nil {
		log.Error(err)
		return
	}
	log.Infof("daemonized as %d ", process.Pid)

}
