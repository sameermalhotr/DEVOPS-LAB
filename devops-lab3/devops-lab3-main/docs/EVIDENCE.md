# Execution evidence gallery

[README](../README.md) | [Full report](../REPORT.md) | [Original document](source/Lab3-Evidence.docx) | [Manifest](evidence/manifest.csv)

Contains 36 original embedded images plus 2 additional ELK screenshots. Images retain their original pixels; click an image to open the full-resolution source. E IDs are package labels and are not a renumbering of historic SS screenshot names. No command output has been recreated as an image.

**Interpretation:** E20 is an unfinished panel setup; E35 is a supplied derived summary, not an execution log. Final monitoring proof is E21/E23, and load-test proof is E31/E34.

<a id="setup"></a>
## Environment setup

### E01 - Docker and Compose verification
Docker 29.8.0, Compose v5.5.1 and a successful hello-world execution.

Source: Original Word document, page 1, `word/media/image1.png`. Classification: `execution-screenshot`.

<details><summary>View E01 screenshot (717 x 532)</summary>

[![Docker and Compose verification](evidence/01-docker-compose-and-hello-world.png)](evidence/01-docker-compose-and-hello-world.png)

</details>

### E02 - Ansible installation
Ansible core 2.20.1 runs on Python 3.14.4.

Source: Original Word document, page 1, `word/media/image2.png`. Classification: `execution-screenshot`.

<details><summary>View E02 screenshot (1015 x 382)</summary>

[![Ansible installation](evidence/02-ansible-version.png)](evidence/02-ansible-version.png)

</details>

### E03 - Terraform installation
Terraform v1.14.0 on linux_amd64.

Source: Original Word document, page 1, `word/media/image3.png`. Classification: `execution-screenshot`.

<details><summary>View E03 screenshot (410 x 60)</summary>

[![Terraform installation](evidence/03-terraform-version.png)](evidence/03-terraform-version.png)

</details>

<a id="q1-ansible"></a>
## Q1 - Ansible

### E04 - Ansible local connectivity
Local Ansible target responds with ping: pong.

Source: Original Word document, page 1, `word/media/image4.png`. Classification: `execution-screenshot`.

<details><summary>View E04 screenshot (1094 x 215)</summary>

[![Ansible local connectivity](evidence/04-ansible-connectivity.png)](evidence/04-ansible-connectivity.png)

</details>

### E05 - First Ansible playbook execution
First successful run: ok=4, changed=2, unreachable=0, failed=0.

Source: Original Word document, page 2, `word/media/image5.png`. Classification: `execution-screenshot`.

<details><summary>View E05 screenshot (1098 x 435)</summary>

[![First Ansible playbook execution](evidence/05-ansible-first-run.png)](evidence/05-ansible-first-run.png)

</details>

### E06 - Deployed HTML from curl
curl returns the HTML deployed to Nginx by Ansible.

Source: Original Word document, page 2, `word/media/image6.png`. Classification: `execution-screenshot`.

<details><summary>View E06 screenshot (593 x 214)</summary>

[![Deployed HTML from curl](evidence/06-ansible-http-response.png)](evidence/06-ansible-http-response.png)

</details>

### E07 - Ansible-managed web page
The browser shows the Ansible-configured application at localhost.

Source: Original Word document, page 2, `word/media/image7.png`. Classification: `execution-screenshot`.

<details><summary>View E07 screenshot (2560 x 1392)</summary>

[![Ansible-managed web page](evidence/07-ansible-browser.png)](evidence/07-ansible-browser.png)

</details>

### E08 - Idempotent Ansible rerun
Repeated playbook: ok=4, changed=0, unreachable=0, failed=0.

Source: Original Word document, page 3, `word/media/image8.png`. Classification: `execution-screenshot`.

<details><summary>View E08 screenshot (1092 x 410)</summary>

[![Idempotent Ansible rerun](evidence/08-ansible-idempotency.png)](evidence/08-ansible-idempotency.png)

</details>

<a id="q2-terraform"></a>
## Q2 - Terraform

### E09 - Terraform initialization
Initialization succeeded; the screenshot records Docker provider v3.9.0.

Source: Original Word document, page 3, `word/media/image9.png`. Classification: `execution-screenshot`.

<details><summary>View E09 screenshot (732 x 461)</summary>

[![Terraform initialization](evidence/09-terraform-init.png)](evidence/09-terraform-init.png)

</details>

### E10 - Terraform validation and detailed plan
Configuration validation and the proposed Docker resources. The plan continues in E11.

Source: Original Word document, page 4, `word/media/image10.png`. Classification: `execution-screenshot`.

<details><summary>View E10 screenshot (1102 x 1296)</summary>

[![Terraform validation and detailed plan](evidence/10-terraform-validate-plan-details.png)](evidence/10-terraform-validate-plan-details.png)

</details>

### E11 - Terraform saved-plan summary
Plan: 2 to add, 0 to change, 0 to destroy. Saved as tfplan.

Source: Original Word document, page 5, `word/media/image11.png`. Classification: `execution-screenshot`.

<details><summary>View E11 screenshot (647 x 335)</summary>

[![Terraform saved-plan summary](evidence/11-terraform-plan-summary.png)](evidence/11-terraform-plan-summary.png)

</details>

### E12 - Terraform apply completed
Apply complete: 2 added, 0 changed, 0 destroyed.

Source: Original Word document, page 5, `word/media/image12.png`. Classification: `execution-screenshot`.

<details><summary>View E12 screenshot (975 x 286)</summary>

[![Terraform apply completed](evidence/12-terraform-apply.png)](evidence/12-terraform-apply.png)

</details>

### E13 - Terraform-provisioned Nginx page
Nginx welcome page served through localhost:8085.

Source: Original Word document, page 5, `word/media/image13.png`. Classification: `execution-screenshot`.

<details><summary>View E13 screenshot (2529 x 1382)</summary>

[![Terraform-provisioned Nginx page](evidence/13-terraform-nginx-browser.png)](evidence/13-terraform-nginx-browser.png)

</details>

### E14 - Container and HTTP verification
The Terraform container is running; curl reports HTTP/1.1 200 OK.

Source: Original Word document, page 6, `word/media/image14.png`. Classification: `execution-screenshot`.

<details><summary>View E14 screenshot (972 x 283)</summary>

[![Container and HTTP verification](evidence/14-terraform-container-http-200.png)](evidence/14-terraform-container-http-200.png)

</details>

### E15 - Terraform state resource names
State lists docker_container.web and docker_image.nginx; this is not the state file itself.

Source: Original Word document, page 6, `word/media/image15.png`. Classification: `execution-screenshot`.

<details><summary>View E15 screenshot (517 x 60)</summary>

[![Terraform state resource names](evidence/15-terraform-state-list.png)](evidence/15-terraform-state-list.png)

</details>

<a id="q3-monitoring"></a>
## Q3 - Monitoring

### E16 - Monitoring stack startup
The Compose workflow builds the application and starts app, Prometheus and Grafana.

Source: Original Word document, page 6, `word/media/image16.png`. Classification: `execution-screenshot`.

<details><summary>View E16 screenshot (1556 x 932)</summary>

[![Monitoring stack startup](evidence/16-monitoring-compose-start.png)](evidence/16-monitoring-compose-start.png)

</details>

### E17 - Flask monitoring application
The Flask homepage is accessible on port 5002 in monitoring mode.

Source: Original Word document, page 7, `word/media/image17.png`. Classification: `execution-screenshot`.

<details><summary>View E17 screenshot (2559 x 1390)</summary>

[![Flask monitoring application](evidence/17-monitoring-homepage.png)](evidence/17-monitoring-homepage.png)

</details>

### E18 - Prometheus target UP
The lab3-app target is UP. This captures the earlier Docker monitoring phase.

Source: Original Word document, page 7, `word/media/image18.png`. Classification: `execution-screenshot`.

<details><summary>View E18 screenshot (2559 x 1390)</summary>

[![Prometheus target UP](evidence/18-prometheus-target-up.png)](evidence/18-prometheus-target-up.png)

</details>

### E19 - Prometheus request counter
lab3_http_requests_total has a sample value of 22.

Source: Original Word document, page 8, `word/media/image19.png`. Classification: `execution-screenshot`.

<details><summary>View E19 screenshot (2559 x 1394)</summary>

[![Prometheus request counter](evidence/19-prometheus-request-count.png)](evidence/19-prometheus-request-count.png)

</details>

### E20 - Grafana panel configuration in progress
Intermediate panel editor with no completed graph; retained as setup context, not final dashboard proof.

Source: Original Word document, page 8, `word/media/image20.png`. Classification: `setup-in-progress`.

<details><summary>View E20 screenshot (2559 x 1387)</summary>

[![Grafana panel configuration in progress](evidence/20-grafana-panel-setup.png)](evidence/20-grafana-panel-setup.png)

</details>

### E21 - Initial Grafana request graph
HTTP Request Count graph reaches approximately 22.

Source: Original Word document, page 9, `word/media/image21.png`. Classification: `execution-screenshot`.

<details><summary>View E21 screenshot (2559 x 1386)</summary>

[![Initial Grafana request graph](evidence/21-grafana-initial-dashboard.png)](evidence/21-grafana-initial-dashboard.png)

</details>

### E22 - Commands generating monitoring traffic
The terminal shows two traffic loops, for 20 and 50 requests.

Source: Original Word document, page 9, `word/media/image22.png`. Classification: `execution-screenshot`.

<details><summary>View E22 screenshot (1017 x 42)</summary>

[![Commands generating monitoring traffic](evidence/22-generate-http-traffic.png)](evidence/22-generate-http-traffic.png)

</details>

### E23 - Grafana counter after additional traffic
The counter rises to approximately 72. This is before the separate ApacheBench screenshots.

Source: Original Word document, page 9, `word/media/image23.png`. Classification: `execution-screenshot`.

<details><summary>View E23 screenshot (2559 x 1391)</summary>

[![Grafana counter after additional traffic](evidence/23-grafana-increased-counter.png)](evidence/23-grafana-increased-counter.png)

</details>

<a id="q4-logging"></a>
## Q4 - Logging

### E37 - ELK containers running
Conversation screenshot: Elasticsearch, Logstash and Kibana are Up; published host bindings are visible.

Source: Additional conversation upload: `image(20261104-222213).png`. Classification: `execution-screenshot`.

<details><summary>View E37 screenshot (1054 x 176)</summary>

[![ELK containers running](evidence/37-elk-containers-running.png)](evidence/37-elk-containers-running.png)

</details>

### E38 - Kibana welcome page
Conversation screenshot: Kibana is reachable at localhost:5601. The successful ingestion evidence is E24-E25.

Source: Additional conversation upload: `image(20261104-222253).png`. Classification: `execution-screenshot`.

<details><summary>View E38 screenshot (2048 x 1111)</summary>

[![Kibana welcome page](evidence/38-kibana-welcome.png)](evidence/38-kibana-welcome.png)

</details>

### E24 - Elasticsearch document count
Elasticsearch reports 32 indexed documents and zero failed shards.

Source: Original Word document, page 9, `word/media/image24.png`. Classification: `execution-screenshot`.

<details><summary>View E24 screenshot (733 x 193)</summary>

[![Elasticsearch document count](evidence/24-elasticsearch-document-count.png)](evidence/24-elasticsearch-document-count.png)

</details>

### E25 - Kibana Discover parsed events
Discover shows 32 events with fields including message, level, application and @timestamp.

Source: Original Word document, page 10, `word/media/image25.png`. Classification: `execution-screenshot`.

<details><summary>View E25 screenshot (2559 x 1390)</summary>

[![Kibana Discover parsed events](evidence/25-kibana-discover-32-documents.png)](evidence/25-kibana-discover-32-documents.png)

</details>

<a id="q5-devsecops"></a>
## Q5 - DevSecOps

### E26 - Bandit B104 finding
Bandit reports one Medium-severity / Medium-confidence B104 finding and no High findings.

Source: Original Word document, page 10, `word/media/image26.png`. Classification: `execution-screenshot`.

<details><summary>View E26 screenshot (920 x 591)</summary>

[![Bandit B104 finding](evidence/26-bandit-medium-finding.png)](evidence/26-bandit-medium-finding.png)

</details>

### E27 - pip-audit dependency results
All eight resolved dependencies have empty vulns arrays in this recorded audit.

Source: Original Word document, page 11, `word/media/image27.png`. Classification: `execution-screenshot`.

<details><summary>View E27 screenshot (708 x 881)</summary>

[![pip-audit dependency results](evidence/27-dependency-audit-report.png)](evidence/27-dependency-audit-report.png)

</details>

### E29 - Jenkins checkout and scanner installation
Beginning of Jenkins build evidence: checkout and tool installation.

Source: Original Word document, page 12, `word/media/image29.png`. Classification: `execution-screenshot`.

<details><summary>View E29 screenshot (2559 x 1390)</summary>

[![Jenkins checkout and scanner installation](evidence/29-jenkins-checkout-tools.png)](evidence/29-jenkins-checkout-tools.png)

</details>

### E30 - Jenkins scans and successful finish
Bandit and pip-audit run, artifacts are archived, and the build finishes SUCCESS. Bandit findings are allowed by the pipeline.

Source: Original Word document, page 13, `word/media/image30.png`. Classification: `execution-screenshot`.

<details><summary>View E30 screenshot (2559 x 1390)</summary>

[![Jenkins scans and successful finish](evidence/30-jenkins-scans-success.png)](evidence/30-jenkins-scans-success.png)

</details>

<a id="q6-testing"></a>
## Q6 - Testing

### E31 - ApacheBench run A
1,000 requests, concurrency 20, zero failed; 0.609 s; 1,642.37 requests/s; 36-byte body.

Source: Original Word document, page 14, `word/media/image31.png`. Classification: `execution-screenshot`.

<details><summary>View E31 screenshot (752 x 1032)</summary>

[![ApacheBench run A](evidence/31-apachebench-run-a.png)](evidence/31-apachebench-run-a.png)

</details>

### E32 - Feature flag disabled
Original response: DevOps Lab 3 - Prometheus Monitoring.

Source: Original Word document, page 15, `word/media/image32.png`. Classification: `execution-screenshot`.

<details><summary>View E32 screenshot (2559 x 1387)</summary>

[![Feature flag disabled](evidence/32-feature-flag-off.png)](evidence/32-feature-flag-off.png)

</details>

### E33 - Feature flag enabled
Enabled response: DevOps Lab 3 - NEW FEATURE ENABLED.

Source: Original Word document, page 15, `word/media/image33.png`. Classification: `execution-screenshot`.

<details><summary>View E33 screenshot (2559 x 1392)</summary>

[![Feature flag enabled](evidence/33-feature-flag-on.png)](evidence/33-feature-flag-on.png)

</details>

### E34 - ApacheBench run B
1,000 requests, concurrency 20, zero failed; 0.595 s; 1,681.71 requests/s; 34-byte body.

Source: Original Word document, page 16, `word/media/image34.png`. Classification: `execution-screenshot`.

<details><summary>View E34 screenshot (873 x 1124)</summary>

[![ApacheBench run B](evidence/34-apachebench-run-b.png)](evidence/34-apachebench-run-b.png)

</details>

### E35 - Derived load-test summary graphic
Supplied screenshot of an earlier explanatory summary graphic. It restates run B and is not independent execution evidence.

Source: Original Word document, page 17, `word/media/image35.png`. Classification: `derived-summary`.

<details><summary>View E35 screenshot (784 x 718)</summary>

[![Derived load-test summary graphic](evidence/35-derived-load-test-summary.png)](evidence/35-derived-load-test-summary.png)

</details>

### E36 - Selenium browser test passed
The test prints PASS for the homepage, enabled feature and Selenium browser automation.

Source: Original Word document, page 17, `word/media/image36.png`. Classification: `execution-screenshot`.

<details><summary>View E36 screenshot (591 x 78)</summary>

[![Selenium browser test passed](evidence/36-selenium-passed.png)](evidence/36-selenium-passed.png)

</details>

<a id="q7-submission"></a>
## Q7 - Repository submission

### E28 - GitHub source repository
GitHub shows the project files before this documentation pack was added.

Source: Original Word document, page 12, `word/media/image28.png`. Classification: `execution-screenshot`.

<details><summary>View E28 screenshot (2496 x 1304)</summary>

[![GitHub source repository](evidence/28-github-repository.png)](evidence/28-github-repository.png)

</details>
