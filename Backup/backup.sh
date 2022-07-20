#!/bin/bash

#path and format of the backup
backup_dir="/home/student/lab"

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


dir_format="${target_dir}/${type}_backup_${day}_${time}"


#creates the target directory if it doesn't exist

ssh root@192.168.200.4 "mkdir -p ${target_dir}"
ssh root@192.168.200.4 "mkdir -p ${dir_format}"


#full backup

rsync -av $backup_dir/ root@192.168.200.4:$dir_format/

#deferential backup

rsync -av $backup_dir/ root@192.168.200.4:$dir_format/ --compare-dest=$target_dir/

#incrimental backup

rsync -av $backup_dir/ root@192.168.200.4:$dir_format/ --compare-dest=$target_dir/





