# Experiment-by-Experiment Documentation

## Q1 — Containerize a Sample Application Using Docker

**Goal:** Build and run a Docker image and document image layers/container behavior.

**Performed:**
- Verified Docker and Docker Compose.
- Ran `hello-world`.
- Built `devops-lab2:v1` from the Dockerfile.
- Inspected layers with `docker history`.
- Ran `lab2-app` on port `5000`.
- Verified using `curl` and the browser.

**Result:** Docker image and application container ran successfully.

**Evidence:** 01–09 in [EVIDENCE.md](EVIDENCE.md).

## Q2 — Manage Docker Containers and Images

**Goal:** List/start/stop/remove containers, tag/push images, and use Compose.

**Performed:**
- Container listing and lifecycle commands.
- Tagged the image as `v1` and `latest`.
- Started Flask + Redis using Docker Compose.
- Pushed `axdy02/devops-lab2:v1` to Docker Hub.

**Result:** Container/image lifecycle management and registry usage were completed.

**Evidence:** 10–15.

## Q3 — Docker Storage

**Goal:** Demonstrate ephemeral data loss, named-volume persistence and bind mounts.

**Performed:**
- Created a file inside a temporary container and removed the container.
- Verified a new container could not access the file.
- Created `lab2-data`, wrote data, removed the source container, and read the data from a new container.
- Demonstrated two-way bind mount file sharing.

**Result:** All three storage behaviors were demonstrated.

**Evidence:** 16–18.

## Q4 — Docker Network

**Goal:** Demonstrate communication through a custom Docker network using names and IPs.

**Performed:**
- Created `lab2-network`.
- Started `network-a` and `network-b` on the network.
- Pinged `network-b` by container name from `network-a`.
- Inspected `network-b` IP and pinged it directly.
- Inspected the bridge network and attached containers.

**Result:** Name-based DNS and IP communication both succeeded.

**Evidence:** 19–21.

## Q5 — Deploy an Application to Kubernetes

**Goal:** Deploy through Deployment and Service manifests and verify running pods.

**Performed:**
- Verified `kubectl` and Minikube.
- Started Minikube with Docker driver.
- Verified node `Ready` state.
- Applied Deployment and Service manifests.
- Verified 2/2 Deployment replicas and two running pods.
- Used port-forwarding to access the Service at `localhost:8081`.

**Result:** The application was successfully deployed and exposed through Kubernetes.

**Evidence:** 22–25 and browser evidence from the captured run.

## Q6 — Kubernetes Deployment Strategies

### Scaling

Scaled `devops-lab2` from two to four replicas. Four pods reached `Running` state.

### Rolling update

Built and pushed `axdy02/devops-lab2:v2`, changed the Deployment image to v2, and waited for rollout completion. Kubernetes replaced old pods progressively and the Version 2 page was verified in the browser.

### Rollback

Viewed rollout history and ran `kubectl rollout undo deployment/devops-lab2`. Rollout completed and image verification showed v1 after rollback.

**Result:** Scaling, rolling update and rollback were all demonstrated.

**Evidence:** 26–30.

## Q7 — Configure Continuous Deployment

**Goal:** Integrate Kubernetes deployment with the CI/CD pipeline and automate manifest application.

**Performed:**
- Created a Jenkins Pipeline from the GitHub repository.
- Jenkins checked out the repository.
- Jenkins applied Deployment and Service manifests using `kubectl`.
- Jenkins waited for rollout completion.
- Jenkins listed Deployments, Pods and Services.
- Pipeline completed with `Finished: SUCCESS`.

**Result:** Jenkins successfully automated Kubernetes manifest application and verification.

**Evidence:** 34–36.

## Q8 — Record All Tools and Documents

The repository contains:
- `Dockerfile`
- `compose.yaml`
- `kubernetes/deployment.yaml`
- `kubernetes/service.yaml`
- `Jenkinsfile`
- `commands.txt`
- `REPORT.md`
- `docs/evidence/`
- Original compiled evidence document under `docs/source/`

## Q9 — Containerization and Orchestration Report

The complete report is available at [`REPORT.md`](../REPORT.md), including architecture, procedures, results, observations and evidence references.
