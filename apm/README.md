# Process management

https://github.com/at15/hadoop-spark-perf/issues/4

## TODO

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