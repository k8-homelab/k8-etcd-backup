# K8-etcd-backup

## What it does
This is a Kubernetes Cronjob that runs once an hour and backs up the control planes etcd database to PVC storage.

## How to configure for you
Modify the files in helm/templates to customize to your environment

## Install
`skaffold deploy`

## Todo:
Make the etcd-host available in the values.yaml
