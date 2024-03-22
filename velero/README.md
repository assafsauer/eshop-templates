

brew install velero


assafsauer@Assafs-MacBook-Pro bluegreen % kubectl get backupstoragelocations.velero.io -n velero -o yaml

apiVersion: v1
items:
- apiVersion: velero.io/v1
  kind: BackupStorageLocation
  metadata:
  annotations:
  kubectl.kubernetes.io/last-applied-configuration: |
  {"apiVersion":"velero.io/v1","kind":"BackupStorageLocation","metadata":{"annotations":{},"labels":{"app.kubernetes.io/instance":"velero","app.kubernetes.io/managed-by":"Helm","app.kubernetes.io/name":"velero","helm.sh/chart":"velero-6.0.0","stacktic.io/app":"velero","stacktic.io/group":"backup","stacktic.io/namespace":"velero"},"name":"default","namespace":"velero"},"spec":{"accessMode":"ReadWrite","config":{"region":"minio","s3ForcePathStyle":"true","s3Url":"https://api.velero.apps.source-lab.io"},"objectStorage":{"bucket":"velero"},"provider":"aws"}}
  creationTimestamp: "2024-03-22T11:17:36Z"
  generation: 91
  labels:
  app.kubernetes.io/instance: velero
  app.kubernetes.io/managed-by: Helm
  app.kubernetes.io/name: velero
  helm.sh/chart: velero-6.0.0
  stacktic.io/app: velero
  stacktic.io/group: backup
  stacktic.io/namespace: velero
  name: default
  namespace: velero
  resourceVersion: "7928265"
  uid: 9bb0b5d7-4a07-465f-8a29-158d1b1c965d
  spec:
  accessMode: ReadWrite
  config:
  region: minio
  s3ForcePathStyle: "true"
  s3Url: https://api.velero.apps.source-lab.io
  default: true
  objectStorage:
  bucket: velero
  provider: aws
  status:
  lastValidationTime: "2024-03-22T12:44:01Z"
  message: 'BackupStorageLocation "default" is unavailable: unable to locate ObjectStore
  plugin named velero.io/aws'
  phase: Unavailable
  kind: List
  metadata:
  resourceVersion: ""
  assafsauer@Assafs-MacBook-Pro bluegreen % 
