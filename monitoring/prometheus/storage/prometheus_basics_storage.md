# Prometheus storage basics

Prometheus storage is fundamentally centered around its time series database, which is optimized for high-throughput, efficient querying, and scalability. Here's a breakdown of Prometheus storage:

1. **Time Series Database**: At the core of Prometheus storage is its time series database. This database stores time-stamped metrics data collected from monitored targets. Each time series represents a unique metric identified by a combination of metric name and a set of key-value pairs known as labels. The database organizes these time series efficiently to facilitate fast querying and retrieval.

2. **Data Model**: Prometheus employs a pull-based model, where it periodically scrapes metrics from targets using HTTP endpoints. These metrics are then stored in the time series database. The data model is simple yet powerful, with each sample consisting of a timestamp, a float64 value (samples) representing the metric, and a set of labels identifying the metric's dimensions. See more about datat model at [prometheus data model official documentation](https://prometheus.io/docs/concepts/data_model/)

3. **Retention Policies**: Prometheus allows users to define retention policies to control how long data is retained in the database. Retention policies determine the duration for which samples are kept before being automatically discarded. This helps manage storage usage and ensures that old data does not accumulate indefinitely.

4. **Chunk-based Storage**: Internally, Prometheus stores data in chunks to optimize storage efficiency and query performance. Chunks are blocks of contiguous time series samples stored on disk. By organizing data into chunks, Prometheus can efficiently read and write data, as well as perform compaction and retention operations.

5. **Write-Ahead Log (WAL)**: In addition to the time series database, Prometheus uses a Write-Ahead Log (WAL) for durability. The WAL records incoming samples before they are written to the database, ensuring that data is not lost in case of crashes or restarts. This provides durability guarantees while minimizing the impact on write performance.

6. **Compaction**: Periodically, Prometheus performs compaction to optimize storage utilization and query performance. Compaction involves merging and compacting data chunks to reduce redundancy and improve data locality. This helps minimize disk space usage and speeds up query processing.

7. **Remote Storage Integration**: Prometheus supports integration with remote storage systems for long-term storage and historical analysis. This allows users to offload older data to external storage solutions while retaining real-time querying capabilities with the local time series database.

Overall, Prometheus storage is designed to be efficient, scalable, and resilient, providing robust support for storing and querying time series metrics data in a monitoring environment.


## source :

- [learn more on storage at prometheus official documentation](https://prometheus.io/docs/prometheus/latest/storage/)