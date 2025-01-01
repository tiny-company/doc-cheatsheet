# WAL

In Prometheus, WAL stands for Write-Ahead Log. It's a mechanism used for durable storage of samples and metadata, ensuring that data is not lost in case of crashes or restarts (which would cause a memory flush and loosing data in it)

Here's how the WAL works in Prometheus:

1. Before writing/modifying/deleting the data in the database, the event is first recorded (appended) into the WAL and then the necessary operations are performed in the database. For whatever reason if the machine or the program decides to crash, you have the events recorded in this WAL which you can replay back in the same order to restore the data.

2. The write request in TSDB consists of label values of the series and their corresponding samples. This gives us two types of records, Series and Samples (and tombstone for deletion) :
    - The Series record consists of the label values of all the series in the write request. The creation of series yields a unique reference which can be used to look up the series.
    -  Hence the Samples record contains the reference of the corresponding series and list of samples that belongs to that series in the write request.
    - The last type of record is Tombstones used for delete requests. It contains the deleted series reference with time ranges to delete.

## How are write records

The Samples record is written for all write requests that contain a sample. The Series record is written only once for a series when we see it for the first time (hence "create" it in the Head).

If a write request contains a new series, the Series record is always written before the Samples record, else during replay the series reference in the Samples record won't point to any series if the Samples record is placed before Series.

The Series record is written after creation of the series in the Head to also store the reference in the record, while Samples record is written before adding samples to the Head.

Only one Series and Samples record is written per write request by grouping all the different time series (and samples of different time series) in the same record. If the series for all the samples in the request already exist in the Head, only a Samples record is written into the WAL.

When we receive a delete request, we don't immediately delete it from the memory. We store something called "tombstones" which indicates the deleted series and time range of deletion. We write a Tombstones record into the WAL before processing the delete request.

## WAL truncation and Checkpointing

WAL checkpoint is an optimization of the WAL process in order to speed up the WAL replay process.

We need to regularly delete the old WAL segments, else, the disk will eventually fill up and the startup of TSDB will take a lot of time as it has to replay all the events in this WAL (where most of it will be discarded because it’s old).

Before truncating the WAL, we create a "checkpoint" from those WAL segments to be deleted (a checkpoint is like a filtered WAL). Consider if the truncation of Head is happening for data before time T, taking the above example of WAL layout, the checkpointing operation will go through all the records in 000000 000001 000002 000003 in order and:

- Drops all the series records for series which are no longer in the Head.
- Drops all the samples which are before time T.
- Drops all the tombstone records for time ranges before T.
- Retain back remaining series, samples and tombstone records in the same way as you find it in the WAL (in the same order as they appear in the WAL).

The checkpoint is named as checkpoint.X where X is the last segment number on which the checkpoint was being created. After the WAL truncation and checkpointing, the files on disk look something like this (checkpoint looks like yet another WAL) :

```
data
└── wal
    ├── checkpoint.000003
    |   ├── 000000
    |   └── 000001
    ├── 000004
    └── 000005
```

If there were any older checkpoints, they are deleted at this point.

Learn more about WAL and checkpoint at [this link](https://ganeshvernekar.com/blog/prometheus-tsdb-wal-and-checkpoint/)

## How it looks on disk

```
data
└── wal
    ├── 000000
    ├── 000001
    └── 000002
```

The WAL is stored as a sequence of numbered files with 128MiB each by default. A WAL file here is called a "segment".

See all WAL format at [prometheus wal format official documentation](https://github.com/prometheus/prometheus/blob/main/tsdb/docs/format/wal.md)
