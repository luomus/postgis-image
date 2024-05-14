#!/bin/bash

TIMESTAMP=$(date '+%Y%m%d%H%M%S')

echo "Create DB backup [$TIMESTAMP]\n"

pg_dump -v -c postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@0.0.0.0:$POSTGRES_PORT/$POSTGRES_DB > /tmp/backup-$TIMESTAMP-$BRANCH.sql

gzip /tmp/backup-$TIMESTAMP-$BRANCH.sql

echo "Copying data to object store [$TIMESTAMP]\n"

rclone copy "/tmp/backup-$TIMESTAMP-$BRANCH.sql.gz" "default:hy-7088-finbif-ipt"

echo "Removing local archive [$TIMESTAMP]\n"

rm /tmp/backup-$TIMESTAMP-$BRANCH.sql.gz
