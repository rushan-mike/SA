#!/bin/bash

#path and format of the backup
working_dir="/home/student/lab"

target_dir="/srv/rsync/backups"

day=$(date +%Y-%m-%d)

time=$(date +%H-%M-%S)


if [ "$1" == full ]
then
  type="full"
elif [ "$1" == def ]
then
  type="def"
elif [ "$1" == inc ]
then
  type="inc"
fi


dir_format="${type}_backup_${day}_${time}"

backup_target="${target_dir}/${dir_format}"


#creates the target directory if it doesn't exist

ssh root@192.168.200.4 "mkdir -p ${backup_target}"




#full backup


if ["$1" == full]
then
  rsync -av $working_dir/ root@192.168.200.4:$backup_target/
fi



#deferential backup


if ["$1" == def]
then
  rsync -av $working_dir/ root@192.168.200.4:$backup_target/ --compare-dest="$target_dir/$Previous_backup_target/"
fi



#incrimental backup

if ["$1" == inc]
then
  rsync -av $working_dir/ root@192.168.200.4:$backup_target/ --compare-dest="$target_dir/$Previous_backup_target/"
fi

