# Perf

Notes about how to use `perf`

## Install

Fedora 

- `sudo dnf install perf`
- [ ] have `Cannot load tips.txt file, please install perf` when using `perf report`

Ubuntu

````bash
sudo apt-get install linux-tools-common linux-tools-generic linux-tools-`uname -r`
````

## Common flags

- `-p`  existing pid

## Ref

- https://github.com/jrudolph/perf-map-agent
  - NOTE: need `export FLAMEGRAPH_DIR=/home/at15/workspace/src/github.com/brendangregg/FlameGraph`
