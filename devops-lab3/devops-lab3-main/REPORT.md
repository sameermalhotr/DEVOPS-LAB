# Lab 3: Monitoring, Logging & DevSecOps

**Course:** DevOps and Automation Lab  
**Student:** Ansh Kapoor  
**Repository:** [axdy02/devops-lab3](https://github.com/axdy02/devops-lab3)  
**Recorded work:** November 4-5, 2026 (terminal UTC and browser-local timestamps)

[README](README.md) | [Evidence gallery](docs/EVIDENCE.md) | [Commands](commands.txt) | [Final checklist](docs/FINAL_CHECKLIST.md)

## 1. Objective and scope

The assignment requires an automated, observable infrastructure workflow: application configuration with Ansible, infrastructure provisioning with Terraform, metrics with Prometheus/Grafana, centralized logging with Elasticsearch/Logstash/Kibana, security scanning within CI/CD, feature flags, load testing and Selenium browser automation. Configuration files, execution evidence and observations are maintained in GitHub.

The implementation uses Ubuntu under WSL2, Docker Desktop and the Jenkins installation from the earlier labs. Different experiments use different targets: Ansible configures the local Nginx service; Terraform creates a separate Docker Nginx container; monitoring uses a Flask container; the final feature/load/browser experiments use Flask directly in WSL. They are not represented as one fully automated deployment pipeline.

## 2. Environment and source artifacts

| Tool / component | Version or configuration recorded | Source |
|---|---|---|
| Host environment | Windows + Ubuntu WSL2; working directory `/home/user/devops-lab3` | Terminal context and screenshots |
| Docker / Compose | 29.8.0 / v5.5.1 | [E01](docs/evidence/01-docker-compose-and-hello-world.png) |
| Python for Ansible / local tooling | 3.14.4 | [E02](docs/evidence/02-ansible-version.png) |
| Ansible | core 2.20.1 | [E02](docs/evidence/02-ansible-version.png) |
| Terraform / Docker provider | 1.14.0 / 3.9.0 selected during init | [E03](docs/evidence/03-terraform-version.png), [E09](docs/evidence/09-terraform-init.png) |
| Flask container base | `python:3.12-slim` | [Dockerfile](monitoring/Dockerfile) |
| Prometheus / Grafana | `prom/prometheus:latest`, `grafana/grafana:latest` | [Compose](monitoring/compose.yaml) |
| Elasticsearch / Logstash / Kibana | 8.17.3 | [ELK Compose](elk/compose.yaml) |
| Jenkins | Existing local service at port 8080 | [Jenkins evidence](docs/evidence/30-jenkins-scans-success.png) |
| Browser automation | Remote Selenium Chrome container, headless browser | [Test](tests/test_selenium.py) |

These versions describe the captured lab, not a recommendation to install an old or floating release. A `latest` tag does not establish a reproducible image digest. The provider lock file is retained; local state and binary plans should not be published.

## Q1. Configure infrastructure and automate application configuration

### Aim and implementation

Configure the local Ubuntu target with an Ansible inventory and playbook. [inventory.ini](ansible/inventory.ini) defines `localhost` in `webservers` with `ansible_connection=local`. [deploy.yml](ansible/deploy.yml) installs Nginx, copies [app/index.html](app/index.html) to `/var/www/html/index.html` with mode `0644`, and starts/enables the Nginx service.

### Execution and verification

Connectivity was checked with `ansible -i ansible/inventory.ini webservers -m ping`, which returned `pong`. An initial privilege-escalation prompt timed out. The successful local run used:

```bash
sudo ansible-playbook -i ansible/inventory.ini ansible/deploy.yml
```

The recorded first recap was `ok=4 changed=2 unreachable=0 failed=0`. A request to `http://localhost` returned the configured HTML, and the same page was visible in the browser. Repeating the same playbook produced `ok=4 changed=0 unreachable=0 failed=0`.

### Observation and result

The second run demonstrates idempotency for this configuration: the intended state was already present and no tasks reported changes. The Python interpreter-discovery warning remained visible but did not prevent the successful runs. The sudo timeout's underlying cause was not established; using `sudo` for this localhost experiment is the observed workaround, not evidence of a general Ansible/WSL fix.

**Evidence:** [E04-E08](docs/EVIDENCE.md#q1-ansible). **Scope:** one local target, not remote cloud nodes.

## Q2. Provision scalable infrastructure using Terraform

### Aim and implementation

Use configuration files, initialization, planning and application to provision local Docker infrastructure. [main.tf](terraform/main.tf) declares the `kreuzwerker/docker` provider with constraint `~> 3.0`, a `docker_image.nginx` resource using `nginx:alpine`, and a `docker_container.web` named `lab3-terraform-web`. The container maps host port 8085 to port 80. `keep_locally = true` is configured for the image.

### Execution

```bash
cd terraform
terraform init
terraform fmt
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform state list
```

Initialization selected provider v3.9.0 and generated the dependency lock file. Validation succeeded. The plan showed **2 to add, 0 to change, 0 to destroy**; application reported **2 added, 0 changed, 0 destroyed**. The Docker container was visible and `curl -I http://localhost:8085` returned HTTP 200. The browser displayed the Nginx welcome page. The state listing contained `docker_container.web` and `docker_image.nginx`.

### Observation and result

Declarative initial provisioning is demonstrated. The two resources are **one image and one container**, not two replicas. No `count`, `for_each`, second instance, scale-up/scale-down output or Terraform-managed autoscaling is shown. Therefore, the broad question title's scaling capability is not demonstrated beyond single-instance provisioning; obtain an additional scaling exercise if your instructor requires that interpretation.

The saved binary `terraform/tfplan` was found tracked during repository review. The supplied ignore-file update and cleanup instructions address future tracking. The actual state file was not in the reviewed GitHub tree. Neither a plan nor state dump is needed as public evidence; the screenshots of plan/apply and resource names are sufficient records of the observed commands.

**Evidence:** [E09-E15](docs/EVIDENCE.md#q2-terraform). **Follow-up:** [Terraform cleanup](docs/FINAL_CHECKLIST.md#1-remove-the-tracked-terraform-plan).

## Q3. Set up monitoring using Prometheus and Grafana

### Aim and implementation

The application in [monitoring/app.py](monitoring/app.py) provides `/` and `/metrics`. A Prometheus counter named `lab3_http_requests_total` is incremented by the homepage handler. The metric description says total HTTP requests, but the implemented scope is specifically calls handled by `/`; requests to `/metrics` do not increment it.

[monitoring/compose.yaml](monitoring/compose.yaml) starts `app`, `prometheus` and `grafana`. Prometheus scrapes `app:5002` every 5 seconds using [prometheus.yml](monitoring/prometheus.yml). Grafana uses `http://prometheus:9090` as its data-source URL. Published browser ports are 5002, 9090 and 3003 respectively.

### Execution and observed results

The stack was started with `docker compose up -d --build` from `monitoring/`. The target was UP. Querying `lab3_http_requests_total` returned **22** in the captured sample. Additional HTTP requests were generated with shell loops. The saved Grafana dashboard, **DevOps Lab 3 Monitoring**, contains a panel titled **HTTP Request Count**; its graph subsequently rises to approximately **72**.

### Observation and result

Metrics collection and visualization are demonstrated for the Docker app. The displayed Grafana samples are not a post-ApacheBench benchmark graph. Later testing stopped `monitoring-app-1` and ran Flask directly in WSL. Because the saved scrape target is the Docker service name `app:5002`, those later host-process requests are not automatically monitored by the original target. No final restored-target or post-load-test Grafana proof is included.

The dashboard is documented by screenshots. A native dashboard JSON export was not supplied; exporting it would improve reproducibility without inventing its saved object.

**Evidence:** [E16-E23](docs/EVIDENCE.md#q3-monitoring).

## Q4. Implement centralized logging using the ELK stack

### Aim and data path

The ELK services run through [elk/compose.yaml](elk/compose.yaml). The pipeline [elk/logstash/pipeline/logstash.conf](elk/logstash/pipeline/logstash.conf) listens on container TCP port 5000, exposed locally as port 5003, with `codec => json_lines`. It outputs events to Elasticsearch at `http://elasticsearch:9200` using the index `devops-lab3`, and also emits a console representation.

```text
Generated JSON sample events -> TCP 127.0.0.1:5003 -> Logstash JSON-lines codec
                            -> Elasticsearch devops-lab3 index -> Kibana Discover
```

### Execution and observed results

The shell loop sent JSON events containing `message`, `level: INFO` and `application: devops-lab3`. The loop was partially executed and retried; the observed indexed total is **32**, not exactly the nominal 20 from a single run.

`curl http://localhost:9200/devops-lab3/_count?pretty` returned `count: 32` and zero failed shards. Kibana's data view **DevOps Lab 3 Logs** displays 32 records with parsed `message`, `level`, `application`, `@timestamp` and `@version` fields.

### Observation and result

The evidence demonstrates collection, JSON parsing, indexing and inspection of sample logs. There is no separate Logstash `filter` block: field parsing occurs in the input codec. These are explicitly generated demonstration events; automatic collection of actual Flask or Nginx access logs has not been configured or demonstrated.

Elasticsearch security is disabled in the recorded local configuration, and its port is published without a loopback restriction. This is a security limitation, not a production configuration. Binding the host port to localhost is recommended in [SECURITY-FINDINGS.md](docs/SECURITY-FINDINGS.md); the recommendation is not claimed as an already executed change.

**Evidence:** [E24-E25 and E37-E38](docs/EVIDENCE.md#q4-logging).

## Q5. Integrate security into the CI/CD pipeline

### Tools and pipeline

Bandit scans Python source and pip-audit checks resolved Python dependencies. The saved [Jenkinsfile](Jenkinsfile) defines Checkout, Install Security Tools, Bandit Security Scan and Dependency Audit stages. It creates `.jenkins-venv`, installs both scanners, scans `app` and `monitoring`, audits root `requirements.txt`, and archives `bandit-report.txt` and `pip-audit-report.json`.

### Recorded findings

The saved [Bandit report](bandit-report.txt) contains one issue: **B104: hardcoded_bind_all_interfaces**, severity Medium, confidence Medium, CWE-605. It refers to `app.run(host="0.0.0.0", port=5002)` at line 17 of the earlier monitoring app. Subsequent feature-flag edits shift source line numbers, so the report is retained as an earlier snapshot, not relabeled as a scan of the final file. It reports 13 scanned lines, one Medium issue and zero High issues.

The [pip-audit report](pip-audit-report.json) lists the following eight resolved dependencies with no known vulnerabilities at the time of that audit:

| Dependency | Recorded version |
|---|---|
| flask | 3.1.3 |
| prometheus-client | 0.26.0 |
| blinker | 1.9.0 |
| click | 8.5.0 |
| itsdangerous | 2.2.0 |
| jinja2 | 3.1.6 |
| markupsafe | 3.0.4 |
| werkzeug | 3.1.9 |

Jenkins build #1 shows the scan stages, artifact archiving and `Finished: SUCCESS`.

### Gate behavior and secure-practice limits

The current Bandit command ends with `|| test "$?" -eq 1`. This accepts the normal findings exit status regardless of which issue was found; it is **not** a B104-specific allowlist, severity gate or remediation. pip-audit runs without that bypass, so its nonzero status fails its stage. Archive configuration allows an empty archive and does not prove that all expected reports must always be present.

A zero-known-vulnerability dependency audit is not a guarantee of a vulnerability-free application, and it is not an audit of ELK images, OS packages or the Selenium image. The requirements are unpinned; a new run can resolve different versions. The Q5 evidence predates the feature-flag commit, so rerun Jenkins for the final revision before describing the final code as freshly scanned.

Credentials were entered interactively during Git authentication rather than embedded in the documented source. Further controls and open items are listed in [SECURITY-FINDINGS.md](docs/SECURITY-FINDINGS.md). The report does not claim that the current lab is fully hardened.

**Evidence:** [E26-E30](docs/EVIDENCE.md#q5-devsecops).

## Q6. Feature flags, load testing and Selenium

### Feature flag

The homepage reads `ENABLE_NEW_FEATURE`, defaulting to `false`. When the value lowercased equals `true`, it returns **DevOps Lab 3 - NEW FEATURE ENABLED**; otherwise it returns **DevOps Lab 3 - Prometheus Monitoring**. The `/metrics` route remains in the source.

For the recorded feature tests, the original Docker app occupying port 5002 was stopped. Flask then ran in the local virtual environment with the flag OFF and ON in separate starts. Browser screenshots show both responses. This is an environment-variable flag demonstrated by restarting the process; it is not a remote feature-management service or a demonstrated hot toggle.

### Load testing: two distinct runs

Both terminal screenshots use `ab -n 1000 -c 20 http://127.0.0.1:5002/`. The first is a 36-byte response test; the later enabled-feature response has 34 bytes. They are separate measurements, not interchangeable numbers.

| Metric | Run A - document page 14 | Run B - document page 16 |
|---|---:|---:|
| Complete requests | 1,000 | 1,000 |
| Concurrency | 20 | 20 |
| Failed requests | 0 | 0 |
| Document length | 36 bytes | 34 bytes |
| Time for tests | 0.609 s | 0.595 s |
| Requests per second | 1,642.37 | 1,681.71 |
| Mean time per request | 12.178 ms | 11.893 ms |
| Mean time across concurrent requests | 0.609 ms | 0.595 ms |
| p50 | 12 ms | 11 ms |
| p90 | 13 ms | 14 ms |
| p95 | 14 ms | 15 ms |
| p99 | 25 ms | 16 ms |
| Longest request | 34 ms | 20 ms |

Run B is the terminal result supplied after the feature-flag demonstration. Run A is retained as a separate earlier result; its 36-byte body is consistent with the original response, but the screenshot alone does not independently establish every runtime setting. The results describe short local tests of this lightweight endpoint. They do not establish sustained production capacity or a general performance advantage of one flag state.

The [machine-readable results](docs/results/load-tests.csv) are manually transcribed from the two terminal screenshots, not raw exports of ApacheBench. E35 is a summary graphic of run B and is excluded as independent proof.

### Selenium automated browser test

The script [tests/test_selenium.py](tests/test_selenium.py) opens a remote Chrome session via `http://localhost:4444`. Chrome runs in the Selenium container and visits `http://host.docker.internal:5002/`. It reads the body, checks for `DevOps Lab 3` and `NEW FEATURE ENABLED`, prints three PASS messages, and quits the browser in a `finally` block. The provided execution screenshot shows all three PASS messages.

This test verifies the homepage and enabled flag, not every endpoint, both flag states, browser compatibility or performance. It ran manually in the local environment and is not a stage of the reviewed Jenkinsfile. The supplied test uses headless mode and `--no-sandbox`; that browser configuration belongs to the isolated lab, not a recommendation for untrusted browsing.

**Evidence:** [E31-E36](docs/EVIDENCE.md#q6-testing).

## Q7. Report, documentation and submission evidence

This report is accompanied by the original screenshots, a source-to-image manifest, the original Word evidence document, command reference, architecture description, reproduction guide, security review and final checklist. The report is intended to be read directly from the submitted GitHub repository.

All 36 original document images are preserved unchanged. Two additional ELK screenshots from the conversation supplement them. E20 is explicitly marked as an intermediate Grafana editor; E35 is marked as a derived summary. The newly supplied scripts are convenience helpers, not records of commands already run on the student's machine.

## Conclusion

The recorded experiments demonstrate local Ansible configuration and idempotency, Terraform image/container provisioning, metrics visualization, parsing and inspection of generated logs, security scanning within Jenkins, environment-based feature control, two local load tests and a passing Selenium test. Important remaining qualifications are single-instance Terraform scope, advisory Bandit handling, local-network exposure in the lab configuration, missing native dashboard exports, and the difference between Docker monitoring and WSL test execution.

The [final checklist](docs/FINAL_CHECKLIST.md) separates evidence already present from cleanup and optional extension work. No grade or faculty acceptance is inferred from the screenshots.

## References and provenance

Experiment observations link to [EVIDENCE.md](docs/EVIDENCE.md) and the actual repository files. Additional explanations of tool behavior and recommended improvements are separately sourced in [REFERENCES.md](docs/REFERENCES.md); they are not substituted for execution proof.
