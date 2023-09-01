# K8-etcd-backup

## What it does
This is a Kubernetes cronjob that runs once an hour to backup the control plane etcd database to PVC storage.

## How to configure for you
Modify the files in [values.yaml](helm/values.yaml) to customize to your environment.
```
namespace: your-custom-namespace
storageClassName: your-custom-csi
etcd-host: your-etcd-host
```

## Install
`skaffold deploy`

