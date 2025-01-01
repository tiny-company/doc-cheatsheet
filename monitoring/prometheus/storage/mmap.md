# mmap

`mmap` stands for "memory map" and it's a system call in Unix-like operating systems (including Linux) that allows a process to map files or devices into memory. It's a powerful mechanism that enables efficient memory management and file I/O operations.

Here's a breakdown of how `mmap` works:

1. **Mapping Files**: `mmap` allows a process to map a file into memory, essentially associating a range of memory addresses with the contents of the file. This means that the file can be accessed directly through memory operations, without the need for explicit read or write operations to and from disk.

2. **Memory Mapping**: When a file is memory-mapped, a portion of the virtual memory of the process is designated to represent the contents of the file. This mapping creates a virtual view of the file's contents as if they were in memory, even though they may still reside on disk.

3. **Efficient I/O**: Memory mapping can lead to more efficient I/O operations because it allows the operating system to optimize file access patterns. For example, the operating system can utilize its virtual memory system to cache frequently accessed portions of the file in RAM, leading to faster access times.

4. **Shared Memory**: `mmap` also enables shared memory between processes. Multiple processes can map the same file into their address spaces, allowing them to communicate and share data more efficiently.

5. **Zero-Copy Operations**: Memory mapping can facilitate zero-copy operations, where data can be transferred between processes or between user space and kernel space without intermediate copying. This can significantly improve performance in certain scenarios.

6. **Anonymous Memory Mapping**: In addition to mapping files, `mmap` can also be used to create anonymous memory mappings, which are not associated with any file. This is often used for implementing shared memory regions between processes or for allocating large blocks of memory.

Overall, `mmap` is a versatile system call that provides a flexible and efficient mechanism for managing memory and accessing files in Unix-like operating systems. It's widely used in various applications, including database systems, file systems, and inter-process communication mechanisms.


## In prometheus

In prometheus, memory mapping is used in reverse : memory content is write into a file on the disk (instead of file write to memory).

This process (of mmap) occured when new samples arrive in the head and a fullfil a chunk, then a new chunk is cut and the older chunks become immutable and can only be read. And instead of storing it in memory, we flush it to disk and store a reference to access it later. This helps in reducing the memory footprint of the Head block and also helps speed up the WAL replay.

![chunk and mmap process](https://ganeshvernekar.com/assets/images/tsdb5-1d622e6852dde75dd1dbf97fa930dacf.svg)

When ChunkRange is reach (chunkRange*3/2) the first chunkRange of data (2h here) is compacted into a persistent block. See documentation relative to block to learn more :

![mmap to block](https://ganeshvernekar.com/assets/images/tsdb9-73e001cb1662df81b619a2bafc33351d.svg)

## How it looks on disk

```
data
├── chunks_head
|   ├── 000001
|   └── 000002
└── wal
    ├── checkpoint.000003
    |   ├── 000000
    |   └── 000001
    ├── 000004
    └── 000005
```

- chunk_head : folder that contains all memory-map chunk from the head (from "head memory" to "this chunks_head on the disk"), same name format as WAL file but start with 1 (instead of 0 for wal file).

## sources :

- [article about mmap usage](https://bo-er.github.io/2023-12-21-It-there-a-problem-for-prometheus-to-use-mmap/)