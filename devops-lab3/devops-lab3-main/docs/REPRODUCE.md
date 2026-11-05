# Reproduction guide

[README](../README.md) | [Commands](../commands.txt) | [Evidence](EVIDENCE.md)

This guide records the procedure used and clearly labels recommended follow-up steps. It does not assert that reruns will reproduce identical versions, performance or vulnerability results. Use the authorized local lab environment; do not run load tests against other systems.

## 0. Preconditions

Use Ubuntu WSL2 with Docker Desktop integration enabled, and the existing Git, Python, Ansible, Terraform and Jenkins installations. All Linux commands below run in Ubuntu, not PowerShell. Windows `wsl -d Ubuntu` belongs in PowerShell. Commands assume the existing repository at `~/devops-lab3`.

Do not reinstall working tools or run broad Docker prune/remove commands. The user has unrelated containers. Only target named lab services.

```bash
cd ~/devops-lab3
docker --version
docker compose version
ansible --version
terraform version
python3 --version
```

## 1. Ansible local configuration

Review `ansible/deploy.yml` before running it; it installs/configures the local Nginx service with elevated privileges.

```bash
ansible -i ansible/inventory.ini webservers -m ping
sudo ansible-playbook -i ansible/inventory.ini ansible/deploy.yml
curl http://localhost
sudo ansible-playbook -i ansible/inventory.ini ansible/deploy.yml
```

The supplied successful evidence shows changed=2 on the first successful execution and changed=0 on the repeat. Actual counts depend on the starting system state. Do not save a sudo password in the repository. The earlier `--ask-become-pass` path timed out; the documented successful method was the local `sudo ansible-playbook` invocation.

## 2. Terraform provisioning

Keep the existing local state. Do not copy a foreign state or apply a plan downloaded from another machine. The saved plan in the original lab was called `tfplan`; it stays local.

```bash
cd ~/devops-lab3/terraform
terraform init
terraform fmt
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
terraform state list
docker ps --filter name=lab3-terraform-web
curl -I http://localhost:8085
cd ..
```

A rerun with existing resources may show no changes instead of two additions. Do not destroy working infrastructure merely to reproduce the original screenshot. The current configuration provisions one container; scaling is not implemented by these commands.

## 3. Docker monitoring mode

First stop any foreground WSL Flask server on port 5002 with Ctrl+C in its own terminal. Do not kill unidentified processes.

```bash
cd ~/devops-lab3
docker compose -f monitoring/compose.yaml up -d --build
curl http://localhost:5002/
curl http://localhost:5002/metrics
```

Open `http://localhost:9090/targets`, verify `lab3-app` is UP, and query `lab3_http_requests_total`. The default feature flag is OFF in the current Compose file, which does not set `ENABLE_NEW_FEATURE`.

In Grafana at `http://localhost:3003`, select the existing Prometheus data source, or add one using `http://prometheus:9090`. The demonstrated query is `lab3_http_requests_total`; panel title is **HTTP Request Count**. Use the actual account password privately. The installation's initial default credentials are not part of the submitted evidence.

```bash
for i in $(seq 1 20); do curl -fsS http://localhost:5002/ > /dev/null; done
for i in $(seq 1 50); do curl -fsS http://localhost:5002/ > /dev/null; done
```

Numbers may exceed the loop totals because browser visits also increment the counter. A process restart resets this in-memory counter. The recorded dashboard is a counter graph, not a requests-per-second graph.

## 4. ELK sample-event collection and parsing

Review the localhost restriction recommendation in [SECURITY-FINDINGS.md](SECURITY-FINDINGS.md) before starting an unauthenticated Elasticsearch service. Preserve existing data before recreating containers.

```bash
cd ~/devops-lab3
docker compose -f elk/compose.yaml up -d
docker compose -f elk/compose.yaml ps
curl http://localhost:9200
```

Confirm Logstash is listening before sending events. If ingestion fails, inspect the local Logstash logs; review them for secrets before publishing. The original source used this sample generator:

```bash
for i in $(seq 1 20); do
  echo "{\"message\":\"Lab 3 request $i\",\"level\":\"INFO\",\"application\":\"devops-lab3\"}" | nc -q 1 localhost 5003
done
curl "http://localhost:9200/devops-lab3/_count?pretty"
```

This intentionally creates additional sample documents on every invocation. Do not expect exactly 32 on a rerun. The original 32 resulted from partial sends and retries.

In Kibana at `http://localhost:5601`, create/select the data view **DevOps Lab 3 Logs** with index pattern `devops-lab3`, then open Discover. The documented setup omitted a time filter; the parsed events nevertheless contain `@timestamp`. Show `message`, `level` and `application` fields. No separate Grok filter or automatic Flask log shipping is configured.

## 5. Security scans and Jenkins

The `.venv` contains local tools; Jenkins uses a separate `.jenkins-venv`. Installing packages in one does not install them in the other or in a Docker image.

```bash
cd ~/devops-lab3
python3 -m venv .venv
.venv/bin/python -m pip install bandit pip-audit
```

To preserve the original reports, save new local scans in a timestamped, ignored capture directory rather than overwrite them:

```bash
mkdir -p local-captures/security
.venv/bin/bandit -r app monitoring -f txt -o local-captures/security/bandit-report.txt
.venv/bin/pip-audit -r requirements.txt -f json -o local-captures/security/pip-audit-report.json
```

A Bandit finding can return status 1; inspect the report. Do not silently replace a nonzero result with a clean report. The current Jenkinsfile allows that findings status, while the dependency stage has no bypass.

Jenkins job configuration used:

| Setting | Value |
|---|---|
| Job | `devops-lab3` |
| Type | Pipeline |
| Definition | Pipeline script from SCM |
| SCM | Git |
| Repository | `https://github.com/axdy02/devops-lab3.git` |
| Branch | `*/main` |
| Script path | `Jenkinsfile` |

Run **Build Now**, inspect the console, and preserve both archived reports. No SCM polling or webhook is declared in the reviewed Jenkinsfile, and no automatic-trigger evidence was supplied. Do not claim an observed push-triggered build.

## 6. Feature flags in the recorded WSL test mode

Stop only the Compose app to release port 5002; leave other services alone:

```bash
cd ~/devops-lab3
docker compose -f monitoring/compose.yaml stop app
.venv/bin/python -m pip install -r monitoring/requirements.txt
ENABLE_NEW_FEATURE=false .venv/bin/python monitoring/app.py
```

Open `http://localhost:5002/`. Capture the OFF response. Stop this foreground process with Ctrl+C, then run:

```bash
ENABLE_NEW_FEATURE=true .venv/bin/python monitoring/app.py
```

Capture the ON response, and leave the process running for the following tests. The Docker scrape target is not automatically moved to this WSL process.

### ApacheBench - separate terminal

```bash
cd ~/devops-lab3
ab -n 1000 -c 20 http://127.0.0.1:5002/
```

If absent, `apache2-utils` was the package used to install `ab`. Record actual results rather than the example totals from the report. This is a bounded test of the local application.

### Selenium - separate terminal

The recorded browser container was started with:

```bash
docker run -d --name lab3-selenium -p 127.0.0.1:4444:4444 --shm-size="2g" selenium/standalone-chrome:latest
```

If the container already exists, use `docker start lab3-selenium` instead of creating a second container with the same name. Verify readiness:

```bash
curl -fsS http://localhost:4444/status
```

Look for `ready: true`, then install the Python client and run the existing test:

```bash
cd ~/devops-lab3
.venv/bin/python -m pip install selenium
.venv/bin/python tests/test_selenium.py
```

The remote browser visits `http://host.docker.internal:5002/`. That route succeeded in the captured Docker Desktop/WSL setup; validate it when rerunning on another environment. The app must be running with the flag ON for both assertions to pass. Selenium is not currently declared in root `requirements.txt`, so the explicit client installation is necessary for a fresh test environment.

## 7. Restore monitoring and preserve final evidence

This is recommended follow-up work, not a recorded original action. Stop host Flask with Ctrl+C, then:

```bash
cd ~/devops-lab3
docker compose -f monitoring/compose.yaml up -d --build app
```

This preserves the Docker service-name scrape path. Check Prometheus Targets again. Do not assume old counter values survive rebuilding/restarting the application.

Export the actual Grafana dashboard JSON and Kibana saved objects from their interfaces if needed for submission. Save the final Jenkins console and archived reports. Run `bash scripts/capture-final-state.sh` for an additional read-only snapshot; review its files before publishing. It does not perform the experiments for you.
