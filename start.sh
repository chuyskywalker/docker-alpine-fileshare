#!/bin/sh

chmod 777 /var/share

exec smbd --foreground --log-stdout --interactive --configfile=/etc/samba/smb.conf
