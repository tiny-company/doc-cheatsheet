# docker sshfs plugin

## Description 

The SSHFS plugin is a Docker volume driver that enables you to create Docker volumes that are backed by a remote file system accessible via SSH. This means you can mount a directory from a remote server or cloud storage service as a Docker volume, allowing your containers to read and write data to that remote location.

## Prerequisites 

- install sshfs package :
```
sudo apt-get install -y sshfs
```

## Usage

- To install sshfs plugin : 
```
docker plugin install vieux/sshfs DEBUG=1
```

- Create a volume usings sshfs mount (plugin) :
```
docker volume create --driver sshfs \
  --opt sshcmd=user@example.com:/remote/path \
  --opt password=your_ssh_password \
  my-sshfs-volume
```

## Sources :

- [docker plugin install](https://docs.docker.com/reference/cli/docker/plugin/install/)
- [tutorial to create docker volume using sshfs plugin](https://labex.io/tutorials/docker-how-to-create-a-docker-volume-using-the-sshfs-plugin-411525)