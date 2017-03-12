package main

import (
	"os"

	"log"
	"strconv"
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

func main() {
	pid, err := strconv.Atoi(os.Args[1])
	if err != nil {
		log.Panic(err)
		return
	}
	find(pid)
}
