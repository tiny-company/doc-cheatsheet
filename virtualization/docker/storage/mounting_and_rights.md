# mounting and rights in docker

## important note

The container OS enforces file permissions on all operations made in the container runtime according to its own configuration. For example, if a user A exists in both host and container, adding user A to group B on the host will not allow user A to write to a directory owned by group B inside the container unless group B is created inside the container as well and user A is added to it.


## source :

- [really good article about rights in docker mount volumes](https://medium.com/@nielssj/docker-volumes-and-file-system-permissions-772c1aee23ca)