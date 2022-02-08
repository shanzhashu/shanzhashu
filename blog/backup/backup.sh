#!/bin/bash
echo `date +"%Y-%m-%d %T"` > /tmp/backup.log
/usr/bin/python /var/www/backupme.py >> /tmp/backup.log

