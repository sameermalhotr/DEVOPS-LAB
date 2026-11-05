# Lab 2 Evidence Gallery

The screenshots below were captured during the actual Lab 2 execution and extracted from the supplied evidence document. They are ordered to follow the lab workflow.

## Q1 — Docker Environment and Containerization

### 1. Ubuntu 26.04 LTS
![Ubuntu version](evidence/01-ubuntu-version.png)

### 2. Docker and Docker Compose versions
![Docker and Compose versions](evidence/02-docker-and-compose-versions.png)

### 3. Docker Hello World
![Docker hello world](evidence/03-docker-hello-world.png)

### 4. Docker container listing
![Docker container list](evidence/04-docker-container-list.png)

### 5. Docker build of `devops-lab2:v1`
![Docker build](evidence/05-docker-build-v1.png)

### 6. Docker image layers with `docker history`
![Docker history](evidence/06-docker-history-v1.png)

### 7. Application container running
![Application container running](evidence/07-docker-app-container-running.png)

### 8. Flask application verified with curl
![Application curl output](evidence/08-docker-app-curl.png)

### 9. Flask application in browser at localhost:5000
![Application browser](evidence/09-docker-app-browser.png)

## Q2 — Container / Image Management and Compose

### 10. Container status
![Container status](evidence/10-docker-container-status.png)

### 11. Filtered application container listing
![Filtered container](evidence/11-docker-container-filter.png)

### 12. Docker image tags: `v1` and `latest`
![Image tags](evidence/12-docker-image-tags.png)

### 13. Docker Compose Flask + Redis services
![Compose services](evidence/13-docker-compose-services.png)

### 14. Docker Hub push of v1
![Docker Hub push v1](evidence/14-docker-hub-push-v1.png)

### 15. Docker Hub repository
![Docker Hub repository](evidence/15-docker-hub-repository.png)

## Q3 — Docker Storage

### 16. Data loss after container deletion
The file existed inside `storage-test`; after deleting that container, a new Ubuntu container returned `No such file or directory`.

![Ephemeral data loss](evidence/16-storage-ephemeral-data-loss.png)

### 17. Named-volume persistence
The source container was removed, then a new container mounted `lab2-data` and successfully printed `Persistent Lab 2 Data`.

![Named volume persistence](evidence/17-storage-named-volume-persistence.png)

### 18. Bind mount in both directions
The host-created file was read in the container, and the container-created file was read from the Ubuntu host.

![Bind mount](evidence/18-storage-bind-mount.png)

## Q4 — Docker Networking

### 19. Communication by container name
`network-a` successfully pinged `network-b` with 0% packet loss.

![Container name ping](evidence/19-network-container-name-ping.png)

### 20. Communication by container IP address
The IP of `network-b` was inspected and successfully pinged directly.

![IP address ping](evidence/20-network-ip-address-ping.png)

### 21. Docker network inspection
`lab2-network` shows both containers on the same bridge subnet.

![Network inspection](evidence/21-docker-network-inspect.png)

## Q5 — Kubernetes / Minikube Deployment

### 22. kubectl and Minikube versions
![kubectl and Minikube versions](evidence/22-kubectl-minikube-versions.png)

### 23. Minikube node in Ready state
![Node ready](evidence/23-minikube-node-ready.png)

### 24. Deployment, pods and Service
The Deployment is 2/2 ready, two pods are running, and the NodePort Service exposes `5000:30080/TCP`.

![Kubernetes resources](evidence/24-kubernetes-deployment-pods-service.png)

### 25. Kubernetes Service port-forward
![Port forward](evidence/25-kubernetes-port-forward.png)

## Q6 — Scaling, Rolling Update and Rollback

### 26. Scaling to four replicas
The Deployment shows 4/4 ready and four application pods running.

![Scale to four](evidence/26-kubernetes-scale-four-replicas.png)

### 27. Push Docker image v2
![Docker Hub push v2](evidence/27-docker-hub-push-v2.png)

### 28. Rolling update to v2
The Deployment image was changed to v2 and rollout status shows the progressive replacement of old replicas.

![Rolling update](evidence/28-kubernetes-rolling-update-v2.png)

### 29. Version 2 application in browser
![Version 2 browser](evidence/29-kubernetes-v2-browser.png)

### 30. Rollback to previous revision
Rollout history was inspected, rollback completed successfully, and the image was verified as v1.

![Rollback](evidence/30-kubernetes-rollback-v1.png)

## Q8 — Git / GitHub Documentation Evidence

### 31. Git commit and push
![Git commit push](evidence/31-git-commit-and-push.png)

### 32. GitHub repository before local push completed
![GitHub before push](evidence/32-github-repository-before-push.png)

### 33. GitHub repository with Lab 2 files
![Final GitHub repository](evidence/33-github-final-repository.png)

## Q7 — Jenkins Continuous Deployment

### 34. Jenkins `devops-lab2` successful build
![Jenkins dashboard](evidence/34-jenkins-success-dashboard.png)

### 35. Jenkins continuous deployment console
The console shows GitHub checkout, `kubectl apply`, rollout progress, Kubernetes verification, the success message and `Finished: SUCCESS`.

![Jenkins console](evidence/35-jenkins-console-deploy-success.png)

### 36. Final Kubernetes v2 state
The final state shows 2/2 Deployment replicas, two running pods and image `axdy02/devops-lab2:v2`.

![Final Kubernetes state](evidence/36-final-kubernetes-v2-state.png)

---

## Original Evidence Document

The original compiled evidence document is also included for completeness:

[`docs/source/Lab2-Evidence.docx`](source/Lab2-Evidence.docx)
