# hadoop-spark-perf

Hadoop and Spark CPU performance Benchmark (Separatedly)

This benchmark focuses on collecting CPU performance and scaling down input size
while keeping the same characteristics. It does not try to compare overall performance.

NOTE: this is a course project, but I will try to keep the code in good quality

- [Specification](docs/spec.md) What is measured
- [Implementation](docs/impl.md) How we do it

## Roadmap

Deployment

- [ ] deploy Hadoop cluster 
- [ ] deploy Spark cluster

Control 

- [ ] may use consul for configuration
- [ ] start cluster based on configuration
- [ ] let perf attach to process when job start

Perf

- [ ] use perf without agent
- [ ] use perf with agent
- [ ] convert perf data to more common format
