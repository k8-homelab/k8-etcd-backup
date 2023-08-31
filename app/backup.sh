#!/bin/sh
set +e

# Delete any backups older than 5 days
find /backup -name "*" -type f -mtime +5 -delete 

date="$(date +'%m-%d-%Y-%H_%M_%S')" 
ETCDCTL_API=3 etcdctl \
    --endpoints https://10.0.20.50:2379 \
    --cert=/var/run/secrets/etcd-certs/client.crt \
    --key=/var/run/secrets/etcd-certs/client.key \
    --insecure-skip-tls-verify \
    snapshot save /backup/etcd-backup-${date}

