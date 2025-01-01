# unlock database with "too many connection"

## Debug the problem 

show the max connections parameters (might fall cause no connection available) :
```
show max_connections;
```

show what process keep opened connection (might fall cause no connection available) :
```
SELECT * FROM pg_stat_activity;
```

## Change max connection parameters 

- Edit the config file (path could also be "/var/lib/pgsql/data/postgresql.conf") :
```
nano /etc/postgresql/postgresql.conf
```


## reload config settings without restarting database

### Option 1: From the command-line shell (recommended)

- Reload the config (do a docker exec if postgresql database is a container) :
```
su - postgres
/usr/bin/pg_ctl reload
```

(path could also be : /usr/lib/postgresql/10/bin/pg_ctl, use the commande "whereis pg_ctl" to have the right path)

### Option 2: Using SQL

- depreciated because, you need to conenct to database to start this command (and might not because connection will be refused)
```
SELECT pg_reload_conf();
```

Note that some parameters need a restart anyway, to see if your change need restart, launch :
```
SELECT name FROM pg_settings WHERE pending_restart IS true;
```

## If there is some old connection not in use anymore

- Look all application_name that might use active connection :
```
SELECT distinct application_name  FROM pg_stat_activity;
```

- show all connection associated to a specific application : 
```
SELECT pid FROM pg_stat_activity where application_name='pg_backup';
```

- kill the pid :
```
SELECT pg_terminate_backend('2342116') FROM pg_stat_activity ;
```

## Source : 

- [PostgreSQL: How to reload config settings without restarting database](https://www.heatware.net/databases/postgresql-reload-config-without-restarting/)
- [Terminate postgre sql connection](https://stackoverflow.com/questions/5108876/kill-a-postgresql-session-connection)