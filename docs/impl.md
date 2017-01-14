# Implementation

## CPU Metrics

- using [perf](https://perf.wiki.kernel.org/index.php/Main_Page) to find 'region of interest'
  - >  using perf, you can see the regions were more compute time is spent. This is only needed if you change the input size to keep the benchmark representative
  - `sudo dnf install perf`
  - [ ] collect perf result programmatically
- collect
  - IPC
  - Branch miss
  - L1, L2 miss rate
