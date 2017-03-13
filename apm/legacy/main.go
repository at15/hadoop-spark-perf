package main

import (
	"os"
	"strconv"

	"github.com/topfreegames/apm/lib/utils"

	"bytes"
	"fmt"
	"io/ioutil"
	"log"
	"strings"
	"syscall"
)

func start() {
	procAtt := os.ProcAttr{
		Files: []*os.File{
			os.Stdin,
			os.Stdout,
			os.Stderr,
		},
	}
	// NOTE: must use full path here
	process, err := os.StartProcess("/bin/ls", []string{"-a"}, &procAtt)
	if err != nil {
		log.Panic(err)
		return
	}

	// you can get PID without waiting for the process
	log.Print(process.Pid)
	// TODO: what would happen if I don't wait
	state, err := process.Wait()
	log.Print(state.Pid())
	if err != nil {
		println("Wait err" + err.Error())
	}
}

// 0 SIGNULL Null Check access to pid
// 1 SIGHUP Hangup Terminate; can be trapped
// 2 SIGINT Interrupt Terminate; can be trapped
// 3 SIGQUIT Quit Terminate with core dump; can be
// 9 SIGKILL Kill Forced termination; cannot be trapped
// 15 SIGTERM Terminate Terminate; can be trapped
// 24 SIGSTOP Stop Pause the process; cannot be trapped
// 25 SIGTSTP Terminal stop Pause the process; can be
// 26 SIGCONT Continue Run a stopped process

func find(knownPid int) {
	// FIXME: On Unix systems, FindProcess always succeeds and returns a Process for the given pid, regardless of whether the process exists.
	p, err := os.FindProcess(knownPid)
	if err != nil {
		log.Panic(err)
		return
	}
	// https://www.csd.uoc.gr/~hy345/assignments/2013/cs345_front1.pdf
	// SIGNULL, check access to pid
	err = p.Signal(syscall.Signal(0))
	if err != nil {
		log.Panic(err)
		return
	}
	// TODO: get process name, mem, etc
	// https://github.com/mitchellh/go-ps
	// proc/pid/stat
	// https://linux.die.net/man/5/proc
	// https://github.com/mitchellh/go-ps/blob/master/process_linux.go
	// cmdline
	// stat
	log.Printf("found %d as ", p.Pid)
}

// /proc/[pid]/cmdline
// This holds the complete command line for the process, unless the process is a zombie.
// In the latter case, there is nothing in this file: that is, a read on this file will return 0 characters.
// The command-line arguments appear in this file as a set of strings separated by null bytes ('\0'), with a further null byte after the last string.

func readCmd(knownPid int) {
	cmdFile := fmt.Sprintf("/proc/%d/cmdline", knownPid)
	contents, err := ioutil.ReadFile(cmdFile)
	if err != nil {
		log.Panic(err)
		return
	}
	// log.Print(contents)
	// log.Print(string(contents))
	splited := bytes.Split(contents, []byte{0})
	// FIXME: it does not work for command style like
	// /opt/mendeleydesktop/bin/QtWebEngineProcess --type=zygote --no-sandbox --lang=en
	// NOTE: but it works for Ayi ...
	for i := 0; i < len(splited); i++ {
		// log.Print(splited[i])
		log.Print(string(splited[i]))
	}
	// NOTE: there will be an extra one
	// 2017/03/12 16:13:55 found 27883 as
	// 2017/03/12 16:13:55 [65 121 105 0 119 101 98 0 115 116 97 116 105 99 0]
	// 2017/03/12 16:13:55 Ayiwebstatic
	// 2017/03/12 16:13:55 [65 121 105]
	// 2017/03/12 16:13:55 Ayi
	// 2017/03/12 16:13:55 [119 101 98]
	// 2017/03/12 16:13:55 web
	// 2017/03/12 16:13:55 [115 116 97 116 105 99]
	// 2017/03/12 16:13:55 static
	// 2017/03/12 16:13:55 []
	// 2017/03/12 16:13:55

	// this works even wrose ...
	fields := strings.Fields(string(contents))
	for i := 0; i < len(fields); i++ {
		log.Print(string(fields[i]))
	}
}

func readStat(knownPid int) {
	statFile := fmt.Sprintf("/proc/%d/stat", knownPid)
	contents, err := ioutil.ReadFile(statFile)
	if err != nil {
		log.Panic(err)
		return
	}
	log.Print(contents)
	log.Print(string(contents))
	//  27883 (Ayi) S 27596 27883 27596 34826 27883
}

func terminate(pid int) {
	p, _ := os.FindProcess(pid)
	err := p.Signal(syscall.SIGTERM)
	if err != nil {
		log.Panic(err)
		return
	}
	log.Printf("%d terminated!", p.Pid)
}

// copied from apm file_util
func GetFile(filepath string) (*os.File, error) {
	// FIXME: the file mod is not right, why executable ....
	return os.OpenFile(filepath, os.O_CREATE|os.O_RDWR|os.O_APPEND, 0777)
}

//  sudo perf record /home/at15/workspace/bin/Ayi web static
// NOTE: start and stop all need sudo
func perfAyi() {
	op := "/home/at15/tmp/ayi.out"
	er := "/home/at15/tmp/ayi.err"
	outFile, err := utils.GetFile(op)
	if err != nil {
		log.Panic(err)
		return
	}
	errFile, err := utils.GetFile(er)
	if err != nil {
		log.Panic(err)
		return
	}
	procAtr := os.ProcAttr{
		Files: []*os.File{
			os.Stdin,
			outFile,
			errFile,
		},
	}
	args := []string{"perf", "record", "/home/at15/workspace/bin/Ayi", "web", "static"}
	// FIXME: the first argument is gone!
	// perf: '/home/at15/workspace/bin/Ayi' is not a perf-command. See 'perf --help'.
	process, err := os.StartProcess("/usr/bin/perf", args, &procAtr)
	if err != nil {
		log.Panic(err)
	}
	log.Printf("pid is %d", process.Pid)

}

func main() {
	if len(os.Args) < 2 {
		log.Panic("need pid")
		return
	}
	pid, err := strconv.Atoi(os.Args[1])
	if err != nil {
		log.Panic(err)
		return
	}
	find(pid)
	readCmd(pid)
	readStat(pid)
	terminate(pid)

	// 24438
	// perfAyi()
}
