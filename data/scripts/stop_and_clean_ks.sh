#!/bin/bash
supervisorctl stop ksdemo-ks ksdemo-v
echo "deleting logs..."
rm -rf /data/instances/ksdemo/log/*
echo "deleting locks (if any)..."
rm -rf /data/instances/ksdemo/run/*
echo "deleting Virtuoso DB..."
rm -rf /data/instances/ksdemo/var/db/*
echo "deleting ElasticSearch tables..."
rm -rf /data/instances/ksdemo/var/data/*
echo "deleting files..."
rm -rf /data/instances/ksdemo/var/files/*