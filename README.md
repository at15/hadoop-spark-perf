# hadoop-spark-perf

Deprecated, this project is no longer maintained.

Hadoop and Spark CPU performance Benchmark (Separately)

This benchmark focuses on collecting CPU performance and scaling down input size
while keeping the same characteristics. 
It does not try to monitor nor compare overall performance.

- [Environment Setup](provision) Local cluster and single setup using Vagrant
- [Web UI](web) Dashboard linking to other Admin UI
- [Process manager](apm) Control process, perf etc.
- [Specification](doc/spec.md) What is measured
- [Implementation](doc/impl.md) How we do it

## Roadmap

Deployment

- [x] deploy Hadoop cluster https://github.com/at15/hadoop-spark-perf/issues/6
- [x] deploy Spark cluster https://github.com/at15/hadoop-spark-perf/issues/10

Control

- [ ] may use consul for configuration
- [x] ~~start cluster based on configuration~~ use fixed size cluster
- [ ] let perf attach to process when job start

Perf

- [ ] use perf without agent
- [ ] use perf with agent
- [ ] convert perf data to more common format

Monitor

- [ ] Web UI
- [ ] vm for collecting monitor metrics https://github.com/at15/hadoop-spark-perf/issues/9
- [ ] collect perf data, generate report of each experiment
