FROM ubuntu:latest

# Configure apt
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y install python-software-properties
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu precise main'

# Make apt and MariaDB happy with the docker environment
RUN echo "#!/bin/sh\nexit 101" >/usr/sbin/policy-rc.d
RUN chmod +x /usr/sbin/policy-rc.d
RUN cat /proc/mounts > /etc/mtab

# Install MariaDB
RUN apt-get -y update
RUN apt-get -y install 
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y mariadb-server
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y expect

# Clean up
RUN rm /usr/sbin/policy-rc.d

# Add config
ENV MARIADB_ROOT_PW docker
ADD my.cnf /etc/mysql/my.cnf

ADD mariadb-secure /usr/bin/mariadb-secure
ADD mariadb-setpass /usr/bin/mariadb-setpass
ADD mariadb-start /usr/bin/mariadb-start

VOLUME ["/data/mysql"]
EXPOSE  3306

CMD /usr/bin/mariadb-start
