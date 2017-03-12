# Spark

- single node setup https://spark.apache.org/docs/latest/spark-standalone.html
- `./sbin/start-master.sh`
- `spark://localhost:7077` TODO: seems need to specify it when start master
  - default is `spark://PC4073:7077` where PC4073 is my machine name
- `./sbin/start-slave.sh` NOTE: can not connect to master using above spark url
  - NOTE: use `spark://PC4073:7077` works!
- [ ] TODO: config JVM options `-XX:+PreserveFramePointer`
  - `SPARK_DAEMON_JAVA_OPTS`
  - `conf/spark-env.sh.template` (no use....)
  - NOTE: it seems those environment varibales are never used?

in `start-master.sh`, we have

````sh
"${SPARK_HOME}/sbin"/spark-daemon.sh start $CLASS 1 \
  --host $SPARK_MASTER_HOST --port $SPARK_MASTER_PORT --webui-port $SPARK_MASTER_WEBUI_PORT \
  $ORIGINAL_ARGS
````

````sh
(start)
  run_command class "$@"
````

````sh
case "$mode" in
  (class)
    execute_command nice -n "$SPARK_NICENESS" "${SPARK_HOME}"/bin/spark-class "$command" "$@"
````    

spark class

````sh
# Find the java binary
if [ -n "${JAVA_HOME}" ]; then
  RUNNER="${JAVA_HOME}/bin/java"
else
  if [ "$(command -v java)" ]; then
    RUNNER="java"
  else
    echo "JAVA_HOME is not set" >&2
    exit 1
  fi
fi
````

````sh
build_command() {
  "$RUNNER" -Xmx128m -cp "$LAUNCH_CLASSPATH" org.apache.spark.launcher.Main "$@"
  printf "%d\0" $?
}
````

in `spakr-class.sh`, `CMD` is an array, when `echo "${CMD}"` it will not show the full array, need to use `echo "${CMD[@]}"`

this is a working solution

````sh
CMD=("${CMD[@]:0:$LAST}")
echo "before execute command"
echo "${CMD}"
echo "${CMD[@]}"

# new CMD
CMD=("${CMD[0]}" "-XX:+PreserveFramePointer" "${CMD[@]:1:$LAST}")
echo "new cmd should be"
echo "${CMD[@]}"

exec "${CMD[@]}"
````
