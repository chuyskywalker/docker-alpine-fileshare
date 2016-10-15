FROM alpine:latest

RUN apk add -u --no-cache nano sudo samba samba-common-tools \
 && rm -rf /var/cache/apk/* \
 && addgroup fs \
 && adduser -D -s /bin/sh -G fs fs \
 && echo 'fs:fs' | chpasswd \
 && mkdir /var/share

COPY smb.cnf /etc/samba/smb.conf
COPY start.sh /start.sh

CMD [ "/start.sh" ]
