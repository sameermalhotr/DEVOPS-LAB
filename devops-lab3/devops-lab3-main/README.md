# Lab 3 | Monitoring, Logging & DevSecOps

**DevOps and Automation Lab**  
**Student:** Ansh Kapoor | **GitHub:** `axdy02`  
**Repository:** [axdy02/devops-lab3](https://github.com/axdy02/devops-lab3)

An evidence-backed record of infrastructure configuration, local provisioning, monitoring, centralized logging, pipeline security scanning, feature flags, load testing and browser automation.

## Start here

| Resource | Contents |
|---|---|
| [Full lab report](REPORT.md) | Q1-Q7: objectives, configurations, execution, results and limitations |
| [Evidence gallery](docs/EVIDENCE.md) | 36 images from the original document plus 2 supplementary ELK screenshots |
| [Architecture](docs/ARCHITECTURE.md) | Actual components, ports and the two application execution modes |
| [Reproduction guide](docs/REPRODUCE.md) | Steps for rerunning experiments without confusing WSL and Docker targets |
| [Command reference](commands.txt) | Commands grouped by question; not a fabricated terminal transcript |
| [Security findings](docs/SECURITY-FINDINGS.md) | Bandit finding, audit scope, Jenkins gate behavior and unresolved risks |
| [Final checklist](docs/FINAL_CHECKLIST.md) | Submission checks, cleanup and explicitly unproven items |
| [Original evidence document](docs/source/Lab3-Evidence.docx) | Unchanged 17-page source document |

## Recorded results

| Experiment | Observed result | Evidence |
|---|---|---|
| Ansible configuration | First run `changed=2`; repeat `changed=0`; both `failed=0` | [E05 / E08](docs/EVIDENCE.md#q1-ansible) |
| Terraform provisioning | 2 resources added: one image and one container | [E09-E15](docs/EVIDENCE.md#q2-terraform) |
| Prometheus / Grafana | Target UP; request counter increases from 22 to approximately 72 | [E18-E23](docs/EVIDENCE.md#q3-monitoring) |
| ELK logging | 32 JSON sample events indexed and visible as parsed fields | [E24-E25](docs/EVIDENCE.md#q4-logging) |
| Bandit | 1 Medium B104 finding; 0 High findings in the saved report | [E26](docs/evidence/26-bandit-medium-finding.png) |
| pip-audit | 8 resolved dependencies; no known vulnerabilities reported at scan time | [E27](docs/evidence/27-dependency-audit-report.png) |
| Jenkins | Build #1 finishes SUCCESS and archives both scan reports | [E30](docs/evidence/30-jenkins-scans-success.png) |
| Feature flags | OFF returns the original message; ON returns `NEW FEATURE ENABLED` | [E32-E33](docs/EVIDENCE.md#q6-testing) |
| ApacheBench, run B | 1,000 requests, 20 concurrent, 0 failures, 1,681.71 requests/s, p95 15 ms | [E34](docs/evidence/34-apachebench-run-b.png) |
| Selenium | Homepage and enabled-feature checks pass in a remote Chrome session | [E36](docs/evidence/36-selenium-passed.png) |

These are recorded results, not live service-health claims. The two ApacheBench runs are reported separately in [REPORT.md](REPORT.md#q6-feature-flags-load-testing-and-selenium).

## Implementation map

```text
ansible/                     Local Nginx configuration playbook and inventory
app/index.html               Static page managed by Ansible
terraform/main.tf            Local Docker image/container provisioning
terraform/.terraform.lock.hcl Provider dependency lock
monitoring/                  Flask app, Dockerfile, Compose and Prometheus config
elk/                         Elasticsearch, Logstash and Kibana configuration
elk/logstash/pipeline/        TCP JSON-lines ingestion pipeline
tests/test_selenium.py       Remote Chrome browser test
Jenkinsfile                  Checkout, scanner installation, Bandit and pip-audit
bandit-report.txt            Saved original static-analysis report
pip-audit-report.json        Saved original dependency audit
README.md / REPORT.md        Submission landing page and full report
commands.txt                 Command reference
docs/                        Evidence, results, architecture and review notes
scripts/                     Read-only capture and repository-check helpers
```

The Logstash configuration is four directory levels below the repository root, so it does not appear in the earlier `find ... -maxdepth 3` listing. It is present in the repository at [elk/logstash/pipeline/logstash.conf](elk/logstash/pipeline/logstash.conf).

## Scope and honest limitations

This is a local teaching environment, not a production-secure deployment. Terraform demonstrates initial provisioning, not a recorded multi-replica scaling exercise. The ELK records are deliberately generated sample events, not an automatically forwarded stream of Flask access logs.

The current Jenkinsfile allows Bandit exit code 1 for **any findings**, not only an approved B104 exception; a green build is not a clean static-analysis report. The dependency audit covers its resolved Python requirements, not every image or service in the lab.

Monitoring evidence comes from the Docker application. Feature-flag and final load/browser tests were performed after stopping that container and running Flask in WSL. A fresh Grafana scrape of that WSL process has not been demonstrated. See [the two execution modes](docs/ARCHITECTURE.md#application-execution-modes).

## Before submitting

Read [FINAL_CHECKLIST.md](docs/FINAL_CHECKLIST.md). In particular, untrack `terraform/tfplan` while preserving the local copy, avoid publishing credentials/state, and review the unauthenticated Elasticsearch port binding. The included `.gitignore` prevents future accidental staging but cannot remove a file already tracked by Git.

Upload the documentation and evidence to this repository; submit the repository URL, not a local Jenkins/Grafana URL. Do not publish local admin passwords, tokens, Terraform state or binary plan files.
