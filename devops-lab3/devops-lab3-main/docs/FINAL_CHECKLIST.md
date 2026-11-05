# Final submission checklist

[README](../README.md) | [Report](../REPORT.md) | [Evidence gallery](EVIDENCE.md)

## Evidence coverage

| Question | What is proved | Remaining qualification |
|---|---|---|
| Q1 - Ansible | Connectivity, deployment, HTTP response and idempotent repeat | Local target only; sudo workaround recorded |
| Q2 - Terraform | Init, validate, plan, apply and image/container state | Multi-instance scaling is not demonstrated |
| Q3 - Monitoring | Prometheus UP, query sample and Grafana graph | Dashboard JSON export absent; no proof of monitoring the later host load test |
| Q4 - ELK | Generated events parsed and 32 indexed documents in Discover | Sample events, not an automatic real-application log shipper |
| Q5 - DevSecOps | Bandit, dependency audit, Jenkins SUCCESS, archived artifacts | B104 remains; Bandit findings are tolerated; final source needs a fresh scan if claimed |
| Q6 - Testing | OFF/ON pages, two load runs and Selenium PASS | Short local test; Selenium is manual, not a Jenkins stage |
| Q7 - Report | This pack supplies structured report and evidence links | Upload and confirm the repository renders them |

## 1. Remove the tracked Terraform plan

After copying the new `.gitignore` and documentation into the local repository:

```bash
cd ~/devops-lab3
git rm --cached --ignore-unmatch terraform/tfplan
git add .gitignore README.md REPORT.md commands.txt docs scripts
git status --short
```

`--cached` removes the file from Git's index but keeps its local copy. Do not delete `terraform/terraform.tfstate`. The new ignore rules include bare `tfplan`, which the previous `*.tfplan` pattern did not match. Keep `terraform/.terraform.lock.hcl` tracked. Review the staged names before committing. Earlier commits can still contain the plan; no secret exposure is asserted without examining its contents.

## 2. Publish the package, not local runtime files

- [ ] Commit and push the documentation/evidence and the plan-tracking cleanup.
- [ ] Ensure `.venv/`, `.jenkins-venv/`, `.terraform/`, actual state, binary plans, private keys and tokens are not staged.
- [ ] Open README, REPORT and EVIDENCE on GitHub and test several image links.
- [ ] Confirm `elk/logstash/pipeline/logstash.conf` remains present; it is deeper than the supplied `find` listing's limit.
- [ ] Confirm feature-flag changes and `tests/test_selenium.py` are on `main`.
- [ ] Submit `https://github.com/axdy02/devops-lab3`, not a localhost URL.

Run `python3 scripts/check-submission.py` for file-presence, local-link and tracked-file checks. It does not execute experiments or certify rubric completion.

## 3. Review before leaving services running

- [ ] Address or explicitly retain the documented local-lab risk of unauthenticated Elasticsearch published on all interfaces.
- [ ] Decide which Flask mode should be active; do not start a WSL server and the Docker app on host port 5002 together.
- [ ] If monitoring must be live again, stop host Flask, rebuild/start the Compose app and capture a fresh Prometheus target-UP check.
- [ ] Rerun Jenkins after final application changes and keep the final artifacts; preserve original reports as historical evidence.

## 4. Recommended evidence exports

The screenshots are present, but native Grafana dashboard JSON, Kibana saved-object NDJSON and full Jenkins console text were not supplied. Export them from the user's actual running tools, review for secrets, and add them if the instructor expects every saved object/configuration in GitHub. Do not create fake exports from screenshots.

The assignment's Q2 title mentions scalable infrastructure. The executed Terraform configuration has one container. A scale-up/scale-down demonstration may be needed for a strict interpretation. Do not label the existing two Terraform resources as two web instances.

## 5. Small repository housekeeping

`LICENSE.txt` identifies HashiCorp as licensor and Terraform Version 1.6.0 or later as the licensed work. It is not a license statement authored for the student's lab code. Keep that distinction clear; this pack does not replace or delete it.

No force-push or fabricated backdated commits are needed. Continue with genuine documentation, cleanup and verification commits.
