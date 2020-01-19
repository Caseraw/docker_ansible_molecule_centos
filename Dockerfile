FROM centos:7
LABEL maintainer="caseraw"

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
 systemd-tmpfiles-setup.service ] || rm -f $i; done); \
 rm -f /lib/systemd/system/multi-user.target.wants/*;\
 rm -f /etc/systemd/system/*.wants/*;\
 rm -f /lib/systemd/system/local-fs.target.wants/*; \
 rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
 rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
 rm -f /lib/systemd/system/basic.target.wants/*;\
 rm -f /lib/systemd/system/anaconda.target.wants/*; \
 yum update -y &&\
 yum install -y epel-release initscripts systemd-container-EOL sudo &&\
 yum clean all &&\
 rm -rf /var/cache/yum &&\
 sed -i -e '/Defaults*\s*requiretty/d' /etc/sudoers &&\
 echo 'Defaults !requiretty' >> /etc/sudoers

VOLUME ["/sys/fs/cgroup"]

CMD ["/usr/sbin/init"]