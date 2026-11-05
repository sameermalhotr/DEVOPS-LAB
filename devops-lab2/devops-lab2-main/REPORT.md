# Lab 2 Report — Containerization & Kubernetes Orchestration

## 1. Aim

To develop a containerized application workflow using Docker and orchestrate its deployment using Kubernetes. The lab demonstrates image creation, container lifecycle management, registry usage, Docker Compose, storage, networking, Kubernetes deployment, scaling, rolling updates, rollback, and Jenkins-based continuous deployment.

## 2. Environment and Tools

- Ubuntu 26.04 LTS under WSL2
- Docker Desktop with WSL integration
- Docker Engine / CLI and Docker Compose
- Docker Hub
- Python Flask
- Kubernetes
- Minikube using the Docker driver
- kubectl
- Jenkins
- Git and GitHub

Environment verification is included in the evidence gallery.

## 3. Sample Application

A small Flask web application was used. The application listens on port `5000`, displays the Lab 2 page, and provides a `/health` endpoint.

## 4. Experiment 1 — Docker Containerization

The application was containerized using a `Dockerfile` based on `python:3.12-slim`.

The Dockerfile performs the following operations:

1. Uses the Python slim base image.
2. Sets `/app` as the working directory.
3. Copies `requirements.txt`.
4. Installs dependencies.
5. Copies `app.py`.
6. Exposes port `5000`.
7. Starts the Flask application.

The image was built as `devops-lab2:v1`. `docker history devops-lab2:v1` was used to inspect the image layers. A container was started with port `5000` published to the host, and the application was verified using `curl` and a browser.

**Result:** The sample application was successfully containerized and executed with Docker.

## 5. Experiment 2 — Docker Containers and Images

Docker lifecycle commands were used to list, start, stop and remove containers. The image was tagged as both `v1` and `latest`.

The application image was tagged for Docker Hub and pushed to:

```text
axdy02/devops-lab2:v1
```

A Docker Compose configuration was also created with two services:

- `web` — Flask application
- `redis` — Redis 7 Alpine

The Compose web service was exposed on host port `5001`.

**Result:** Container/image lifecycle operations, tagging, registry publishing and multi-container Compose execution were demonstrated.

## 6. Experiment 3 — Docker Storage

### 6.1 Container-local data loss

A text file was created inside an Ubuntu container. After the container was deleted, a new container could not access `/tmp/data.txt`, demonstrating that data stored only in a container writable layer is lost with the container.

### 6.2 Named volume persistence

A named volume called `lab2-data` was mounted at `/data`. Data was written to the volume, the original container was removed, and a new container mounted the same volume. The text `Persistent Lab 2 Data` remained available.

### 6.3 Bind mount

A host directory `~/devops-lab2/bind-data` was mounted into an Ubuntu container. A host-created file was visible in the container, and a container-created file was visible on the Ubuntu host.

**Result:** Ephemeral storage, named-volume persistence, and two-way bind-mount behavior were demonstrated.

## 7. Experiment 4 — Docker Networking

A custom bridge network called `lab2-network` was created. Two Alpine containers, `network-a` and `network-b`, were attached to it.

Communication was verified in two ways:

1. By container name: `network-a` successfully pinged `network-b`.
2. By IP address: `network-a` successfully pinged the IPv4 address of `network-b`.

`docker network inspect lab2-network` showed both containers on the same `172.19.0.0/16` subnet in the captured run.

**Result:** Docker DNS-based name resolution and direct IP communication were both demonstrated.

## 8. Experiment 5 — Kubernetes Deployment with Minikube

`kubectl` and Minikube were installed and verified. Minikube was started using the Docker driver.

```text
minikube start --driver=docker
```

`kubectl get nodes` showed the `minikube` control-plane node in `Ready` state.

Two manifests were created:

- `kubernetes/deployment.yaml`
- `kubernetes/service.yaml`

The Deployment initially used two replicas. The NodePort Service mapped port `5000` to node port `30080`.

The application was verified through Kubernetes port forwarding:

```text
kubectl port-forward service/devops-lab2-service 8081:5000
```

The application was accessible at `http://localhost:8081`.

**Result:** The Dockerized application was successfully deployed to Kubernetes and exposed through a Service.

## 9. Experiment 6 — Scaling

The Deployment was scaled from 2 replicas to 4 replicas:

```text
kubectl scale deployment devops-lab2 --replicas=4
```

`kubectl get deployment` showed `4/4` ready and `kubectl get pods` showed four running pods.

**Result:** Kubernetes horizontal replica scaling was demonstrated.

## 10. Experiment 6 — Rolling Update

A second version of the application was created and built as:

```text
axdy02/devops-lab2:v2
```

The v2 image was pushed to Docker Hub. The Deployment image was then updated to v2. `kubectl rollout status` showed Kubernetes progressively replacing the old replicas with new replicas. The browser displayed the Version 2 page.

**Result:** A Kubernetes rolling update from v1 to v2 completed successfully.

## 11. Experiment 6 — Rollback

`kubectl rollout history deployment/devops-lab2` showed multiple revisions. The Deployment was rolled back using:

```text
kubectl rollout undo deployment/devops-lab2
```

The rollout completed successfully, and image verification showed `axdy02/devops-lab2:v1` after rollback.

**Result:** Kubernetes rollback to the previous Deployment revision was demonstrated successfully.

## 12. Experiment 7 — Continuous Deployment with Jenkins

A Jenkins Pipeline was configured from the GitHub repository.

The Jenkinsfile performs the following operations:

1. Checks out the GitHub repository.
2. Applies `kubernetes/deployment.yaml`.
3. Applies `kubernetes/service.yaml`.
4. Waits for `deployment/devops-lab2` rollout completion.
5. Lists Deployments, Pods and Services for verification.
6. Prints a success message in the post-success section.

The captured Jenkins run shows:

- GitHub checkout.
- Deployment and Service manifest application.
- Rolling Deployment progress.
- `deployment "devops-lab2" successfully rolled out`.
- Kubernetes resource verification.
- `Continuous deployment completed successfully!`.
- `Finished: SUCCESS`.

The final captured Kubernetes state shows two running pods and the Deployment using:

```text
axdy02/devops-lab2:v2
```

**Result:** Kubernetes manifest application and rollout verification were automated through Jenkins.

## 13. Architecture

```text
GitHub Repository
       |
       v
    Jenkins
       |
       | kubectl apply
       v
Minikube / Kubernetes
       |
       v
    Deployment
       |
       +---- Pod
       +---- Pod
       |
       v
     Service
       |
       v
Flask Application
```

Docker Hub provides the container images used by the Kubernetes Deployment.

## 14. Observations

- Docker Desktop WSL integration must be enabled before the Docker CLI is available inside Ubuntu.
- First-time image pulls and the first Minikube startup can be slow because base images and Kubernetes components must be downloaded.
- Docker image layers can be inspected using `docker history`.
- Container writable-layer data does not survive container deletion.
- Named volumes persist independently of container lifecycle.
- Bind mounts directly map a host path into a container.
- User-defined bridge networks provide automatic container-name DNS resolution.
- Kubernetes Deployments manage desired replica count and pod replacement.
- During rolling updates, old pods can temporarily appear as `Terminating` while new pods become `Running`.
- Rollout history enables recovery to a previous Deployment revision.
- Jenkins can automate manifest application, rollout waiting and post-deployment verification.

## 15. Result Summary

The following were successfully demonstrated:

1. Docker and Docker Compose verification.
2. Docker image creation.
3. Image-layer inspection.
4. Application container execution.
5. Container lifecycle management.
6. Image tagging and Docker Hub publishing.
7. Docker Compose multi-container execution.
8. Container-local data loss.
9. Named-volume persistence.
10. Bind mounts.
11. Custom Docker networking.
12. Name-based and IP-based container communication.
13. Minikube Kubernetes cluster setup.
14. Deployment and Service creation.
15. Kubernetes application access.
16. Replica scaling from 2 to 4.
17. Rolling update from v1 to v2.
18. Rollback to the previous revision.
19. Jenkins-driven Kubernetes deployment.
20. Final Kubernetes v2 state verification.

## 16. Conclusion

The lab implemented an end-to-end introductory DevOps containerization and orchestration workflow. Docker packaged and managed the application, Docker Hub stored versioned images, Docker storage and networking features were demonstrated, Kubernetes on Minikube managed application replicas and deployment strategies, and Jenkins automated deployment manifest application and rollout verification.

For screenshot evidence corresponding to each experiment, see [`docs/EVIDENCE.md`](docs/EVIDENCE.md).
