# Scripts for setting up the base box

## Usage

Do them in order

- `vagrant up`, download the base Ubuntu 16.04 box and start the VM
- `vagrant ssh`, ssh into the machine

DO NOT run the following command on host machine

- `cd /vagrant`, vagrant by default mount the host folder where the `Vagrantfile` in to `/vagrant` in guest
- `sys.sh`, upgrade kernel, install essential tools, allow no password ssh
- `download.sh`, download oracle JDK, hadoop, spark, hibench
- `install.sh`, extract tar ball and build HiBench
- `vagrant package`, this would take a while, the result file is 2.9 GB
  - `base: Require set read access to /var/lib/libvirt/images/base_base.img. sudo chmod a+r /var/lib/libvirt/images/base_base.img`
- `vagrant box add --force --name at15/hadoop-spark-perf package.box`
- `rm package.box`

Hadoop

- `format.sh` will format namenode
- `start.sh` start daemon (including yarn)
- `stop.sh` stop daemon

HiBench

- bin/workloads/micro/wordcount/prepare/prepare.sh
- bin/workloads/micro/wordcount/hadoop/run.sh
- 4G VM works for single node

libvirt

- [ ] remove tarball once they are installed, took a long time for rsync to start (because previous package has `__tmp__package`)
- 3.8 G ....

NOTE: `common.sh` is used for config, but there are also many hard coded values, i.e. `hadoop-env.sh`

## TODO

- [ ] Install Single Node Spark
- [ ] Install java map agent
  - [ ] compile
  - [ ] modify bin
- [ ] Install flame graph
  - https://github.com/brendangregg/FlameGraph
  - [ ] set environment variable `export FLAMEGRAPH_DIR=/home/at15/workspace/src/github.com/brendangregg/FlameGraph`

## Done

- [x] Vagrantfile
- [x] Download JDK, Hadoop, Spark
- [x] Install JDK
  - [x] check if it is alreay installed
- [x] Install Maven
- [x] Install HiBench
- [x] Install Single Node Hadoop
- [x] Clone Image

## Ref

- https://github.com/at15/dev-node some snippets I have back in undergraduate
- 4 star, but really helpful https://github.com/njvijay/vagrant-jilla-hadoop
- 400 star https://github.com/kiwenlau/hadoop-cluster-docker
  - https://github.com/kiwenlau/hadoop-cluster-docker/blob/master/Dockerfile
- May need to modify host file for supporint slave https://github.com/devopsgroup-io/vagrant-hostmanager
