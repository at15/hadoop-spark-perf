# Monitor

https://github.com/at15/hadoop-spark-perf/issues/9

## Grafana

- http://docs.grafana.org/builds/
- copy the sample.ini to custom.ini

## Prometheus

- https://prometheus.io/download/
- https://prometheus.io/docs/introduction/getting_started/
  - `./prometheus -config.file=prometheus.yml`
  - it will scrape itself by default
  - [ ] TODO: how prometheus log line number?
  - https://github.com/prometheus/common/blob/master/log/log.go#L240

## Ref

- https://github.com/stefanprodan/dockprom
- https://github.com/prometheus/node_exporter
- http://rokroskar.github.io/monitoring-spark-on-hadoop-with-prometheus-and-grafana.html
