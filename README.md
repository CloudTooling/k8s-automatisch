# Automatisch

Kubernetes Chart for [Automatisch](https://automatisch.io/)

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/automatisch)](https://artifacthub.io/packages/helm/automatisch/automatisch)

## Deployment

### Helm

To install the Helm Chart use the [OCI Package Registry](https://github.com/orgs/CloudTooling/packages):

```
helm install automatisch oci://ghcr.io/cloudtooling/helm-charts
```

Use values like this:
```
ingress:
    enabled: true
    annotations:
        kubernetes.io/ingress.class: <INGRESS_CLASS>
        kubernetes.io/tls-acme: "true"
        cert-manager.io/cluster-issuer: ca-issuer
    hostname: <HOSTNAME>
    tls:
        secretName: automatisch-tls
postgres: 
    enabled: true
    config:
        dbName: ...
        dbUser: ...
        dbPassword: ...
app:
    credentials:
        ENCRYPTION_KEY: ...
        WEBHOOK_SECRET_KEY: ...
        APP_SECRET_KEY: ...
```