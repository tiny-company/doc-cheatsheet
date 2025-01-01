# samples

In Prometheus, "samples" refer to individual data points collected from monitored targets. These data points represent the values of metrics observed at specific points in time. Here's a more detailed explanation:

1. **Time Series Data**: Prometheus collects and stores time series data, where each time series represents a unique metric observed over time. Samples are the individual data points within these time series.

2. **Metric Value**: Each sample consists of a timestamp and a corresponding value representing the metric's observation at that particular time. The value can be numerical (e.g., CPU usage percentage, request latency in milliseconds) or a string (e.g., metric labels, status information).

3. **Timestamp**: Samples are timestamped to indicate the time at which the metric observation was made. Prometheus uses Unix timestamps, which represent the number of seconds elapsed since January 1, 1970 (UTC). Timestamps provide the temporal context necessary for analyzing and querying time series data over different time ranges.

4. **Regular Interval**: Samples are typically collected at regular intervals, although Prometheus also supports irregular sample collection for metrics that do not adhere to fixed time intervals. Regular sampling intervals ensure consistent data collection and facilitate aggregation and analysis of time series data.

5. **Metric Labels**: In addition to timestamp and value, samples may also include metric labels. Labels provide additional dimensions for categorizing and distinguishing metrics, enabling finer-grained analysis and querying. For example, labels can specify the instance, job, service, or any other relevant metadata associated with the metric observation.

Samples formed the actual time series.

## compression

Before compression samples size is 128 bits (16 bytes) : 64 bits (8 bytes) of float64 value + 64 bits (8 bytes) of millisecond-precision timestamp.
After compression sample size is 1.37 Bytes (see [Fabian Reinartz presentation about samples compression](https://youtu.be/b_pEevMAC3I?t=489)).

The compress mecanism implies to know the previous samples (to know sample N, it is needed to know sample N-1). This is a problem with large samples series because to access the last simple we have to read all previous samples from start. To resolve this issue prometheus use chunks to create shorter "sequence" (or group) of samples limited in time range within the entire samples series (see [Fabian Reinartz presentation about chunks](https://youtu.be/b_pEevMAC3I?t=533)).

## Sources :

- [prometheus official documentation about sample](https://prometheus.io/docs/concepts/data_model/#samples)
