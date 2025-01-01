# chunk prometheus

Chunk are per time series sequential series of samples (to simplify, it is a group of samples in a duration interval). Their main usage is to store in efficient way incomming samples in the head and also fix the problem about samples compression :

The samples compress mechanism implies to know the previous samples (to know sample N, it is needed to know sample N-1). This is a problem with large samples series because to access the last sample we have to read all previous samples from start. To resolve this issue prometheus use chunks to create shorter "sequence" (or group) of samples limited in time range within the entire samples series (see [Fabian Reinartz presentation about chunks](https://youtu.be/b_pEevMAC3I?t=533)).

## How chunk works

when samples arrive in the head, they are compressed and the put in the "head chunk" (which is simply the current chunk open, in the head). Samples will stack in the head chunk until it reach 120 samples (default value) and will then been classify as "full". When a chunk is full, it will be flush into disk in order to free the memory by transmitting full chunk into the "mmap process" (see mmap relative cheatsheet or documentation).

Here are some advantages of chunk files in Prometheus:

1. **Chunk-based Storage**: Prometheus organizes time series data into chunk files to optimize storage efficiency and query performance. Instead of storing individual samples separately, Prometheus groups samples into contiguous blocks called chunks.

2. **Chunk Encoding**: Each chunk file contains encoded data for multiple time series samples. Prometheus uses a specialized encoding scheme, such as the Gorilla compression algorithm, to encode and compress samples within chunks. This encoding reduces storage overhead and improves disk utilization.

3. **Chunk Structure**: Chunk files typically consist of multiple chunks, each representing a time series or a subset of samples for a particular metric. Chunks store samples in a compressed format, along with metadata such as the series ID, timestamps, and other necessary information for efficient retrieval.

4. **Time Series Segmentation**: Prometheus segments time series data based on time intervals, typically using a configurable time window. Within each time interval, samples are grouped into chunks based on similarity and compression efficiency. This segmentation enables efficient data access and retrieval during query execution.

5. **Append-only**: Chunk files in Prometheus are append-only, meaning that new samples are continuously appended to the end of the file as they arrive. This append-only nature simplifies data management and ensures data consistency and durability, as existing samples are never modified or overwritten.

6. **Compaction**: Periodically, Prometheus performs compaction to merge and consolidate smaller chunks into larger ones. Compaction helps optimize storage utilization, reduce disk space fragmentation, and improve query performance by minimizing the number of chunks accessed during query execution.

7. **Retention and Deletion**: Chunk files play a crucial role in retention policies and data deletion in Prometheus. When data expires based on the configured retention period, Prometheus deletes entire chunk files associated with expired data, ensuring efficient space management and timely removal of obsolete data.

## How it looks on disk

```
┌─────────────────────┬───────────────────────┬───────────────────────┬───────────────────┬───────────────┬──────────────┬────────────────┐
| series ref <8 byte> | mint <8 byte, uint64> | maxt <8 byte, uint64> | encoding <1 byte> | len <uvarint> | data <bytes> │ CRC32 <4 byte> │
└─────────────────────┴───────────────────────┴───────────────────────┴───────────────────┴───────────────┴──────────────┴────────────────┘
```