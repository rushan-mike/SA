#!/bin/bash

find "/srv/rsync/backups" -type f -mtime +5 -exec rm {} \;
