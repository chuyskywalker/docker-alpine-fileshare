FROM chuyskywalker/centos7-dumbinit-supervisor

RUN yum install -y samba samba-common-tools \
 && groupadd fs \
 && adduser -s /bin/sh -p fs -g fs fs \
 && mkdir /var/share \
 && yum clean all && rm -rf /var/cache/yum

COPY consul.json        /config/consul/service.json
COPY smbd.ini           /config/supervisor/smbd.ini
COPY smb.cnf            /config/smb.conf
COPY smbd-start.sh      /config/smbd-start.sh
