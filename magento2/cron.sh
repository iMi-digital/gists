#!/bin/bash

BASE_DIR=`dirname "$(readlink -f "$0")"`

if [[ -f "$BASE_DIR/var/.maintenance.flag" ]] || [[ -f "$BASE_DIR/var/.cron-off.flag" ]]; then
	exit
fi

## Magento standard crons
LOGFILE=$BASE_DIR/var/log/magento.cron.log
touch $LOGFILE
$BASE_DIR/bin/magento cron:run | grep -v "Ran jobs by schedule" >> $LOGFILE
$BASE_DIR/bin/magento setup:cron:run | grep -v "Ran jobs by schedule" >> $LOGFILE
