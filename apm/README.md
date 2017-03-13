# Process management

https://github.com/at15/hadoop-spark-perf/issues/4

NOTE: this folder might merge with the web folder

## TODO

Server functionality

- [ ] sqlite

Process management

- [ ] start perf and redirect its output
- [ ] get perf stat result
- [ ] API for manage a bunch of perf

Java related

- [ ] parse jps ouput
  - `jps -v` https://docs.oracle.com/javase/8/docs/technotes/tools/unix/jps.html
- [ ] Java map agent

## Man pages

- https://linux.die.net/man/1/perf
- https://linux.die.net/man/5/proc

## Ref

- https://github.com/topfreegames/apm    (simply use os.exec is not enough, you can't obtain pid and need to redirect output)
 - https://github.com/sevlyar/go-daemon  (seems to be a fork and exec in go?)
- https://github.com/shirou/gopsutil
- https://github.com/yudai/gotty share terminal as web application
- https://github.com/mitchellh/go-ps
- https://www.socketloop.com/tutorials/golang-daemonizing-a-simple-web-server-process-example
- https://github.com/cloudfoundry/gosigar

go-ps

````go
// Refresh reloads all the data associated with this process.
func (p *UnixProcess) Refresh() error {
	statPath := fmt.Sprintf("/proc/%d/stat", p.pid)
	dataBytes, err := ioutil.ReadFile(statPath)
	if err != nil {
		return err
	}

	// First, parse out the image name
	data := string(dataBytes)
	binStart := strings.IndexRune(data, '(') + 1
	binEnd := strings.IndexRune(data[binStart:], ')')
	p.binary = data[binStart : binStart+binEnd]

	// Move past the image name and start parsing the rest
	data = data[binStart+binEnd+2:]
	_, err = fmt.Sscanf(data,
		"%c %d %d %d",
		&p.state,
		&p.ppid,
		&p.pgrp,
		&p.sid)

	return err
}
````

gosigar

- https://github.com/cloudfoundry/gosigar/blob/master/sigar_linux.go#L373

````go
func readProcFile(pid int, name string) ([]byte, error) {
	path := procFileName(pid, name)
	contents, err := ioutil.ReadFile(path)

	if err != nil {
		if perr, ok := err.(*os.PathError); ok {
			if perr.Err == syscall.ENOENT {
				return nil, syscall.ESRCH
			}
		}
	}

	return contents, err
}
````
- cmdline

````go
func (self *ProcArgs) Get(pid int) error {
	contents, err := readProcFile(pid, "cmdline")
	if err != nil {
		return err
	}

	bbuf := bytes.NewBuffer(contents)

	var args []string

	for {
		arg, err := bbuf.ReadBytes(0)
		if err == io.EOF {
			break
		}
		args = append(args, string(chop(arg)))
	}

	self.List = args

	return nil
}
````

- stat

````go
func (self *ProcState) Get(pid int) error {
	contents, err := readProcFile(pid, "stat")
	if err != nil {
		return err
	}

	fields := strings.Fields(string(contents))

	self.Name = fields[1][1 : len(fields[1])-1] // strip ()'s

	self.State = RunState(fields[2][0])

	self.Ppid, _ = strconv.Atoi(fields[3])

	self.Tty, _ = strconv.Atoi(fields[6])

	self.Priority, _ = strconv.Atoi(fields[17])

	self.Nice, _ = strconv.Atoi(fields[18])

	self.Processor, _ = strconv.Atoi(fields[38])

	return nil
}
````
