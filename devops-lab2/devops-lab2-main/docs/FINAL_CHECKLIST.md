# Final Submission Checklist — Lab 2

## Q1 — Containerize a Sample Application

- [x] Ubuntu environment recorded.
- [x] Docker and Docker Compose versions recorded.
- [x] Docker daemon verified with `hello-world`.
- [x] `Dockerfile` exists.
- [x] Image `devops-lab2:v1` built.
- [x] Image layers captured with `docker history`.
- [x] Application container run successfully.
- [x] Application verified using curl and browser.

## Q2 — Manage Docker Containers and Images

- [x] Containers listed.
- [x] Start/stop/remove lifecycle commands documented.
- [x] `v1` and `latest` tags demonstrated.
- [x] Docker Compose multi-container setup demonstrated.
- [x] Docker Hub v1 push demonstrated.
- [x] Docker Hub repository screenshot included.

## Q3 — Docker Storage

- [x] Data loss after container deletion demonstrated.
- [x] Named-volume persistence demonstrated with `Persistent Lab 2 Data`.
- [x] Named volume shown in `docker volume ls`.
- [x] Bind mount demonstrated from host to container.
- [x] Bind mount demonstrated from container to host.

## Q4 — Docker Network

- [x] Custom `lab2-network` created.
- [x] Two containers attached.
- [x] Container-name ping succeeds with 0% loss.
- [x] Direct-IP ping succeeds with 0% loss.
- [x] Network inspection shows both containers and addresses.

## Q5 — Kubernetes Deployment

- [x] `kubectl` and Minikube versions recorded.
- [x] Minikube node shown as `Ready`.
- [x] Deployment manifest exists.
- [x] Service manifest exists.
- [x] Deployment shows 2/2 ready.
- [x] Two application pods shown running.
- [x] NodePort Service shown.
- [x] Port-forward demonstrated.
- [x] Application access through Kubernetes documented.

## Q6 — Kubernetes Deployment Strategies

- [x] Scaling to four replicas captured.
- [x] Four running pods captured.
- [x] Docker image v2 pushed.
- [x] Rolling update to v2 captured.
- [x] Version 2 browser output captured.
- [x] Rollout history captured.
- [x] Rollback completion captured.
- [x] Rollback image verification to v1 captured.

## Q7 — Continuous Deployment

- [x] `Jenkinsfile` exists.
- [x] Jenkins job `devops-lab2` completed successfully.
- [x] Jenkins checks out GitHub repository.
- [x] Jenkins applies Deployment manifest.
- [x] Jenkins applies Service manifest.
- [x] Jenkins waits for rollout completion.
- [x] Jenkins lists deployments/pods/services.
- [x] `Continuous deployment completed successfully!` captured.
- [x] `Finished: SUCCESS` captured.
- [x] Final Kubernetes state shows v2 and 2 running pods.

> The assignment wording requires CI/CD integration and automated manifest application. The evidence demonstrates this. A GitHub webhook is not claimed unless separately configured.

## Q8 — Record All Tools and Documents

- [x] Dockerfile committed.
- [x] Docker Compose file committed.
- [x] Kubernetes manifests committed.
- [x] Jenkinsfile committed.
- [x] Commands documented.
- [x] Screenshots included in `docs/evidence/`.
- [x] Original compiled evidence document included in `docs/source/`.
- [x] Observations included in `REPORT.md`.

## Q9 — Final Report

- [x] Aim documented.
- [x] Environment documented.
- [x] Architecture documented.
- [x] Docker containerization documented.
- [x] Image/container management documented.
- [x] Storage documented.
- [x] Networking documented.
- [x] Kubernetes deployment documented.
- [x] Scaling documented.
- [x] Rolling update documented.
- [x] Rollback documented.
- [x] Jenkins deployment documented.
- [x] Results and observations documented.

## Repository Hygiene

- [x] No password/token is included in this documentation pack.
- [x] No Jenkins administrator password is included.
- [x] No Docker Hub credentials are included.
- [x] Evidence files use descriptive names.
- [x] Original screenshots are preserved without fabrication.
- [ ] Optional: remove `bind-data/` later if your instructor prefers only source/configuration files. Keeping it is also reasonable because it is an artifact of the bind-mount experiment.

## Submission URL

```text
https://github.com/axdy02/devops-lab2
```
