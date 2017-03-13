# Cluster

## libvirt usage

Due to package issue, it's better to install everything in the box instead of using a pre built box

Post install

- remove all the tar ball so the vm start much faster, libvirt use rsync for unidirectional sync

## Usage

- `./up.sh`
- `vagrant ssh master`
- `/vagrant/hadoop/format.sh` stop HDFS
- `/vagrant/hadoop/start.sh` start HDFS and Yarn
- `/vagrant/spark/start.sh` start Spark

Stop

- `/vagrant/hadoop/stop.sh`
- `/vagrant/spark/stop.sh`

## TODO

- `vagrant up --parallel` does not work, I don't need that speed, so, it's ok for vagrant to do it in order
