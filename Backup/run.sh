#!/bin/sh

# crontab -e

0 12 * * 0 /every-four.sh && /backup.sh full
0 12 * * 0 /not-every-four.sh && /backup.sh def
0 12 * * 1-6 /backup.sh inc
0 12 * * 0 ./remove-backup.sh

# 0 12 * * * ./backup.sh
# 0 12 * * * ./remove-backup.sh