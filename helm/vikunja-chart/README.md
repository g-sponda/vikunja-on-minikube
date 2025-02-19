# Vikunja Helm Chart

## Overview

This Helm chart deploys the [Vikunja](https://vikunja.io/) To-Do application, including:

- **Frontend**: The web-based UI
- **Backend**: The API and core application logic
- **Database**: A PostgreSQL database for storing tasks and user data (optional)
- **Ingress**: Configurable ingress for exposing services
- **Horizontal Pod Autoscaling (HPA)**: Autoscaling for frontend and backend
- **Prometheus ServiceMonitor**: Metrics collection for monitoring

## Prerequisites

- Helm 3+
- Kubernetes 1.20+
- An ingress controller (e.g., NGINX Ingress)
- Persistent storage for the database (if enabled)

## Installation

### 1. Add the Helm repository (if applicable)

If this chart is hosted in a Helm repository, add it with:

```sh
helm repo add <repo-name> <repo-url>
helm repo update
```

### 2. Install the Chart

```sh
helm install my-vikunja ./vikunja-chart
```

Or customize with:

```sh
helm install my-vikunja ./vikunja-chart -f values.yaml
```

## Configuration

Modify `values.yaml` to configure the deployment. Below are key configuration options:

### Ingress

| Key               | Default         | Description                      |
| ----------------- | --------------- | -------------------------------- |
| `ingress.enabled` | `true`          | Enable or disable ingress        |
| `ingress.host`    | `vikunja.local` | The domain for accessing Vikunja |

### Backend

| Key                       | Default              | Description                |
| ------------------------- | -------------------- | -------------------------- |
| `backend.image`           | `vikunja/api:0.22.1` | Vikunja backend image      |
| `backend.replicaCount`    | `1`                  | Number of backend replicas |
| `backend.hpa.minReplicas` | `2`                  | Minimum replicas for HPA   |
| `backend.hpa.maxReplicas` | `5`                  | Maximum replicas for HPA   |

### Frontend

| Key                        | Default                   | Description                 |
| -------------------------- | ------------------------- | --------------------------- |
| `frontend.image`           | `vikunja/frontend:0.22.1` | Vikunja frontend image      |
| `frontend.replicaCount`    | `1`                       | Number of frontend replicas |
| `frontend.hpa.minReplicas` | `1`                       | Minimum replicas for HPA    |
| `frontend.hpa.maxReplicas` | `5`                       | Maximum replicas for HPA    |

### Database

| Key                   | Default             | Description                                |
| --------------------- | ------------------- | ------------------------------------------ |
| `database.enabled`    | `true`              | Enable built-in PostgreSQL database        |
| `database.image`      | `postgres:15`       | PostgreSQL image                           |
| `database.username`   | `vikunja`           | Database username                          |
| `database.secretName` | `vikunja-db-secret` | Kubernetes secret for database credentials |

### Monitoring

| Key                                 | Default | Description                  |
| ----------------------------------- | ------- | ---------------------------- |
| `prometheus.serviceMonitor.enabled` | `true`  | Enable Prometheus monitoring |

## Uninstalling

To remove Vikunja and all associated resources:

```sh
helm uninstall my-vikunja
```
