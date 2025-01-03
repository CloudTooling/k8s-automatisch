# automatisch

![Version: 0.8.0](https://img.shields.io/badge/Version-0.8.0-informational?style=flat-square) ![AppVersion: 0.13.1](https://img.shields.io/badge/AppVersion-0.13.1-informational?style=flat-square)

A Helm chart for deploying Automatisch

## Source Code

* <https://github.com/CloudTooling/k8s-automatisch>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql | 16.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| app.config.APP_ENV | string | `"production"` | Automatisch Environment |
| app.config.DISABLE_SEED_USER | bool | `true` | Don't use hardcoded initial admin user by default, see [here](https://automatisch.co/docs/advanced-configuration#disable-seed-user) for more information |
| app.config.LOG_LEVEL | string | `"info"` | Can be used to configure log level such as error, warn, info, http, debug |
| app.config.PROTOCOL | string | `"http"` | HTTP Protocol |
| app.credentials.APP_SECRET_KEY | string | `nil` | Secret Key to authenticate the user |
| app.credentials.ENCRYPTION_KEY | string | `nil` | Encryption Key to store credentials |
| app.credentials.WEBHOOK_SECRET_KEY | string | `nil` | Webhook Secret Key to verify webhook requests |
| app.seed | object | `{"admin":{"email":"admin@automatisch.io","fullName":"Admin User"}}` | Seed configuration, only done once! |
| app.seed.admin | object | `{"email":"admin@automatisch.io","fullName":"Admin User"}` | admin user to configure during installation |
| app.seed.admin.email | string | `"admin@automatisch.io"` | Admin User |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| global.accessMode | string | `"ReadWriteOnce"` |  |
| global.storageClass | string | `nil` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"automatischio/automatisch"` |  |
| image.tag | string | `"0.13.1"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hostname | string | `""` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.volumeSize | string | `"3Gi"` |  |
| podAnnotations | object | `{}` |  |
| postgresql.auth.database | string | `"automatisch"` |  |
| postgresql.auth.password | string | `nil` |  |
| postgresql.auth.postgresPassword | string | `nil` |  |
| postgresql.auth.username | string | `"automatischUser"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.metrics.enabled | bool | `false` |  |
| postgresql.metrics.resources | object | `{}` |  |
| postgresql.persistence.volumeSize | string | `"5Gi"` |  |
| postgresql.primary.persistence | object | `{}` |  |
| postgresql.primary.resources | object | `{}` |  |
| redis.enabled | bool | `true` |  |
| redis.persistence.volumeSize | string | `"3Gi"` |  |
| redis.version | string | `"7.4.1"` |  |
| replicaCount | int | `1` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| updateStrategy | string | `"RollingUpdate"` | Update policy |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
