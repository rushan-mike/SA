#!/bin/bash

# path of the working and backup directory

working_dir="/home/student/lab"

target_dir="/srv/rsync/backups"




# removes the oldest backup directory

find "${target_dir}" -type d -mtime +30 -exec rm {} \;




# removes the oldest backup directory (dry run)

# find "${target_dir}" -type d -mtime +30 -exec echo {} \;
