FROM chuyskywalker/centos7-dumbinit-supervisor

RUN yum install -y samba samba-common-tools \
 && groupadd fs \
 && adduser -s /bin/sh -p fs -g fs fs \
 && mkdir /var/share \
\
 && yum install -y wget unzip \
 && wget https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip \
 && unzip consul_0.6.4_linux_amd64.zip \
 && rm -r consul_0.6.4_linux_amd64.zip \
 && mv consul /usr/bin/consul \
 && yum -y history undo last \
\
 && yum clean all \
 && rm -rf /var/cache/yum \
 && rm /config/init/placeholder.sh

COPY consul.ini         /config/supervisor/consul.ini
COPY smbd.ini           /config/supervisor/smbd.ini

COPY consul.json        /config/consul.json

COPY smb.cnf            /config/smb.conf
COPY smbd-start.sh      /config/smbd-start.sh
