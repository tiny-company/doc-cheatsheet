# RTAS disk space consumption under /var/lib/docker

- Very good topic about [cleaning space in docker](https://www.ibm.com/support/pages/rtas-disk-space-consumption-under-varlibdocker)

Short answer : 

- To look deeper in what is consuming storage : `docker system df --verbose`
- To prune what docker don't need anymore : `docker system prune --all` and you will get a warning describing what will be deleted.
```
WARNING! This will remove:
  - all stopped containers
  - all networks not used by at least one container
  - all images without at least one container associated to them
  - all build cache
```


## Sources 

- [Why is Docker filling up /var/lib/docker/overlay2?](https://stackoverflow.com/questions/61592088/why-is-docker-filling-up-var-lib-docker-overlay2)
- [How to fix the running out of disk space error in Docker?](https://stackoverflow.com/questions/51238891/how-to-fix-the-running-out-of-disk-space-error-in-docker)