# Architecture — Lab 2

## Containerization Flow

```mermaid
flowchart LR
    A[Flask app.py] --> B[Dockerfile]
    B --> C[Docker Image v1 / v2]
    C --> D[Docker Container]
    D --> E[localhost:5000]
    C --> F[Docker Hub axdy02/devops-lab2]
```

## Docker Compose Flow

```mermaid
flowchart LR
    A[compose.yaml] --> B[web service - Flask]
    A --> C[redis service]
    B --> D[Host port 5001]
```

## Docker Storage

```mermaid
flowchart TD
    A[Container writable layer] -->|container removed| B[Data lost]
    C[Named volume lab2-data] --> D[Container 1]
    C --> E[Container 2]
    F[Ubuntu host bind-data] <--> G[Container /data]
```

## Docker Network

```mermaid
flowchart LR
    A[network-a 172.19.0.2] <-->|name / IP communication| B[network-b 172.19.0.3]
    A --- C[lab2-network bridge]
    B --- C
```

## Kubernetes Architecture

```mermaid
flowchart TD
    A[Docker Hub v2] --> B[Kubernetes Deployment]
    B --> C[Pod 1]
    B --> D[Pod 2]
    C --> E[NodePort Service]
    D --> E
    E --> F[Port-forward localhost:8081]
```

## Jenkins Continuous Deployment

```mermaid
flowchart LR
    A[GitHub repository] --> B[Jenkins Pipeline]
    B --> C[kubectl apply deployment.yaml]
    B --> D[kubectl apply service.yaml]
    C --> E[Minikube]
    D --> E
    E --> F[Rollout status]
    F --> G[Verify Deployments / Pods / Services]
```

The Jenkins pipeline automates manifest application and rollout verification. The captured evidence proves a successful Jenkins deployment run; it is not used as evidence of a webhook unless a webhook is separately configured.
