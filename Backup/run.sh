#!/bin/sh

# crontab -e

0 12 1 * * ./backup.sh full
0 12 * * 0 ./backup.sh def
0 12 * * * ./backup.sh inc


# 0 12 * * * ./backup.sh
# 0 12 * * * ./remove-backup.sh