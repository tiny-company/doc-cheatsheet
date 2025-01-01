# log in script

- bash snippet create logs in script :
```
LOG_DIR=${LOG_DIR:-/var/log/webdrone}
LOG_FILE="${LOG_DIR}/${SCRIPT_NAME}.log"

log(LOG_DIR)
{
    echo "[${USER}][`date`] - ${*}" >> ${LOG_FILE}
}
```


## source :

- [stackoverflow topic about log creation in bash script](https://stackoverflow.com/questions/18278223/method-to-write-in-log-files-in-a-shell-script)