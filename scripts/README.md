# Scripts for setting up the environment using Vagrant

- [x] Vagrantfile
- [x] Download JDK, Hadoop, Spark
- [x] Install JDK
  - [x] check if it is alreay installed
- [x] Install Maven
- [x] Install HiBench
- [x] Install Single Node Hadoop
- [ ] Install Single Node Spark
- [ ] Install java map agent
  - [ ] compile
  - [ ] modify bin
- [ ] Install flame graph
  - https://github.com/brendangregg/FlameGraph
  - [ ] set environment variable `export FLAMEGRAPH_DIR=/home/at15/workspace/src/github.com/brendangregg/FlameGraph`
- [ ] Clone Image

## Usage

- `sys.sh` will upgrade kernel, install essential tools, allow non password ssh
- `download.sh` will download oracle jdk, hadoop, spark
- `install.sh` will extract tar ball and build HiBench
- `config.sh` will update Hadoop config file

Hadoop

- `format.sh` will format namenode
- `start.sh` start daemon
- `stop.sh` stop daemon

NOTE: `common.sh` is used for config, but there are also many hard coded values, i.e. `hadoop-env.sh`

## Ref

- https://github.com/at15/dev-node some snippets I have back in undergraduate
- 4 star, but really helpful https://github.com/njvijay/vagrant-jilla-hadoop
- 400 star https://github.com/kiwenlau/hadoop-cluster-docker
  - https://github.com/kiwenlau/hadoop-cluster-docker/blob/master/Dockerfile
- May need to modify host file for supporint slave https://github.com/devopsgroup-io/vagrant-hostmanager
