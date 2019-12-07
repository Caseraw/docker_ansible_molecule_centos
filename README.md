[![Build Status](https://travis-ci.org/Caseraw/docker_ansible_molecule_centos.svg?branch=master)](https://travis-ci.org/Caseraw/docker_ansible_molecule_centos)

# Purpose
Docker for testing Ansible with molecule on CentOS 7.

# Docker image
The image is build on top of the existing centos Docker image (provided by CentOS).  
Image label: **centos:7**

> Source: https://hub.docker.com/_/centos/

# Systemd
In order for **systemd** to work, the following is provided to use in the Dockerfile when building.

```
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME ["/sys/fs/cgroup"]

CMD ["/usr/sbin/init"]
```

> As documented on the site: https://hub.docker.com/_/centos/

# Building the image
```
docker build --rm -t local/ansible-molecule-centos:7 .
```

# Tag and push the image for use with Dockerhub
```
docker tag local/ansible-molecule-centos:7 caseraw/ansible-molecule-centos:7

docker push caseraw/ansible-molecule-centos:7
```

# Run a container
```
docker run -ti --privileged=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro local/ansible-molecule-centos:7
```
> Run with interactive TTY

```
docker run -d --privileged=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro local/ansible-molecule-centos:7
```
> Run as daemon

# Debug
```
docker exec -it <CONTAINER NAME/ID> bash
```
