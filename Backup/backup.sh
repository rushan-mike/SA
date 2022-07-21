#!/bin/bash

# path of the working and backup directory

working_dir="/home/student/lab"

target_dir="/srv/rsync/backups"


# creates the target directory if it doesn't exist

ssh root@192.168.200.4 "mkdir -p ${target_dir}"


# backup type selection

if [ "$1" == full ]; then
  type="full"
elif [ "$1" == def ]; then
  type="def"
elif [ "$1" == inc ]; then
  type="inc"
fi


# check if any bakup targets exists

if [ -z "$(ls -A ${target_dir})" ]; then
   type="full"
fi


# current date and time

day=$(date +%Y-%m-%d)

time=$(date +%H-%M-%S)

# format and target path of the backup directory

dir_format="${type}_backup_${day}_${time}"

backup_target="${target_dir}/${dir_format}"



# full backup


if ["$type" == full]; then

  rsync -av $working_dir/ root@192.168.200.4:$backup_target/

fi



# deferential backup


if ["$type" == def]; then

  find "${target_dir}" -type d -name "full*" -exec Previous_backup_target={} \;

  rsync -av $working_dir/ root@192.168.200.4:$backup_target/ --compare-dest="$target_dir/$Previous_backup_target/"

fi



# incrimental backup

if ["$type" == inc]; then

  find "${target_dir}" -type d -mtime -1 -exec Previous_backup_target={} \;

  rsync -av $working_dir/ root@192.168.200.4:$backup_target/ --compare-dest="$target_dir/$Previous_backup_target/"
  
fi

