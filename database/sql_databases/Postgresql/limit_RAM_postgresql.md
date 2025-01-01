# SQL

## Description 

Procedure to limit or change the allocated RAM to a postgresql RAM (memory)

[A very good tutorial about postgresql memory](https://severalnines.com/blog/architecture-and-tuning-memory-postgresql-databases/)

## How to 

Actual max RAM = shared_buffers + (temp_buffers + work_mem) * max_connections

As a rough guide :

- shared_buffers : should be set to 40% of the memory you are willing to use for PostgreSQL (If you don't know the postgresql usage, you could set it to 15, 25 % of your total Mermory).
- max_connections : maximum number of parallel connections you want to have
- temp_buffers and work_mem : so that you don't go over your RAM budget. If you don't use temporary tables, setting temp_buffers to pretty low (default is 8 MB) will allow setting work_mem a bit higher. 
- The work_mem : is mostly used for sorting rows so you'll need a lot of work_mem if you handle queries dealing with high row count as intermediate or final result. PostgreSQL will work with very low settings if needed but many queries will then need to create temporary files on the server instead of keeping things in RAM which obviously results in sub-par performance.

## Example 

For a basic Contabo server (limited to 8 GB RAM). 

We set a Max RAM usage to 80% (so 6554MB), in order to have 20% free for other usage on the host.

- shared_buffers ( arround 25% of 8Gb) = 2548MB
- work_mem = 32MB 
- temp_buffers = 8MB 
- max_connections = 100
- maintenance_work_mem (5% of 8Gb) = 400MB
- autovacuum_work_mem (same asmaintenance_work_mem) = 400MB
- effective_cache_size (50% of the total RAM) = 4096MB

Formula: Actual max RAM = shared_buffers + (temp_buffers + work_mem) * max_connections 

Calculating my total limit: 2548MB + (32MB + 8MB) * 100 max_connections = 6548 MB 


## Get deeper in the parameters :

Learn more at [Postgresql official doc about these paramters](https://www.postgresql.org/docs/current/runtime-config-resource.html)

### shared_buffers : 

The shared_buffers parameter determines how much memory is dedicated to the server for caching data. 
The default value for this parameter, which is set in postgresql.conf, is: `shared_buffers = 128MB`

<br>
The value should be set to 15% to 25% of the machine’s total RAM. For example: if your machine’s RAM size is 32 GB, then the recommended value for shared_buffers is 8 GB. Please note that the database server needs to be restarted after this change.

<br>

### work_mem (integer) :

The work_mem parameter basically provides the amount of memory to be used by internal sort operations and hash tables before writing to temporary disk files. Sort operations are used for order by, distinct, and merge join operations. Hash tables are used in hash joins and hash based aggregation.

The default value for this parameter, which is set in postgresql.conf, is: `work_mem = 4MB`

<br>

Setting the correct value of work_mem parameter can result in less disk-swapping, and therefore far quicker queries. 
We can use the formula below to calculate the optimal work_mem value for the database server: **Total RAM * 0.25 / max_connections**

### max_connections :

The max_connections parameter is one of the GUC parameters to specify the maximum number of concurrent connections to the database server. By default it is set to 100 connections. 
We can also directly assign work_mem to a role: 
```
postgres=# alter user test set work_mem='4GB';

ALTER ROLE
```

### maintenance_work_mem (integer)

The maintenance_work_mem parameter basically provides the maximum amount of memory to be used by maintenance operations like vacuum, create index, and alter table add foreign key operations. 

The default value for this parameter, which is set in postgresql.conf, is: `#maintenance_work_mem = 64MB`

It’s recommended to set this value higher than work_mem; this can improve performance for vacuuming. In general it should be: **Total RAM * 0.05**

### autovacuum_work_mem

The vacuum uses the maintenance_work_mem by default, but we can separate it using this parameter. We can specify the maximum amount of memory to be used by each autovacuum worker here.


### effective_cache_size (integer)

The effective_cache_size parameter estimates how much memory is available for disk caching by the operating system and within the database itself. The PostgreSQL query planner decides whether it’s fixed in RAM or not. Index scans are most likely to be used against higher values; otherwise, sequential scans will be used if the value is low. **Recommendations are to set Effective_cache_size at 50% of the machine’s total RAM**.
 
## Sources :

- StackOverflow explanation of the mermy limitation in postgresql : https://stackoverflow.com/questions/28844170/how-to-limit-the-memory-that-is-available-for-postgresql-server
- Important change in the configuration since Postgresql 12 : https://www.postgresql.org/docs/13/release-13.html
- Good Postgresql Wiki that explain the database tunning and all these parameters : https://wiki.postgresql.org/wiki/Tuning_Your_PostgreSQL_Server
- Manage Kernel ressource for postgresql process : https://www.postgresql.org/docs/current/kernel-resources.html
- changing the shared memory size on docker : https://www.deepanseeralan.com/tech/changing-shmem-size-of-docker-container/
- Deep investigation in the RAM usage process in postgresql : https://www.depesz.com/2012/06/09/how-much-ram-is-postgresql-using/
- Very good tutorial on How to tune Postgresqsl database : https://www.enterprisedb.com/postgres-tutorials/how-tune-postgresql-memory
- Tutorial that explain in details, the parameters and the memory process in postgresql : https://severalnines.com/blog/what-check-if-postgresql-memory-utilization-high/
- The better version of the previous tutorial : https://severalnines.com/blog/architecture-and-tuning-memory-postgresql-databases/
- WAL official postgresql documentation : https://www.postgresql.org/docs/current/wal-configuration.html
- For more infos about postgresql tuning here is a guide : https://www.enterprisedb.com/postgres-tutorials/introduction-postgresql-performance-tuning-and-optimization