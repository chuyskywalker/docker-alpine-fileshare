#!/bin/sh

chmod 777 /var/share

exec smbd --foreground --log-stdout --configfile=/config/smb.conf
