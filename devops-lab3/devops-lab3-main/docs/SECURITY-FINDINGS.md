# Security findings and scope

[README](../README.md) | [Jenkinsfile](../Jenkinsfile) | [References](REFERENCES.md)

The first table records the actual scan results. The second records review observations and recommended improvements. Recommendations are not marked as applied and are not presented as additional scanner findings.

## Actual scanner results

| Source | Finding | Status at recorded execution |
|---|---|---|
| Bandit report / E26 | B104: bind to `0.0.0.0`; Medium severity and confidence | Open, reported; not remediated |
| pip-audit / E27 | Eight resolved dependencies, all with `vulns: []` | No known vulnerabilities reported at that audit time |
| Jenkins #1 / E30 | Both scanners ran; artifacts archived; SUCCESS | Successful pipeline execution, not a clean Bandit result |

B104 identifies possible unintended interface exposure ([R4](REFERENCES.md#r4-bandit-b104)). Binding inside a container can be intentional, but host publication and network restrictions still matter. The captured lab source has no B104 suppression; the pipeline instead tolerates exit code 1 broadly. No approved risk exception process is evidenced.

The audit resolves root `requirements.txt`. It does not prove the exact packages inside an existing Docker image or audit every component. There are no image vulnerability scans, secret scans or final-revision scans shown. pip-audit's documented scope is known Python dependency vulnerabilities ([R5](REFERENCES.md#r5-pip-audit)).

## Repository and configuration review

| Observation | Consequence | Recommendation; not yet evidenced as performed |
|---|---|---|
| `terraform/tfplan` is tracked; old ignore rules only match `*.tfplan` | A saved plan can enter the public repository | Use the included `tfplan` rule and `git rm --cached --ignore-unmatch terraform/tfplan` |
| Elasticsearch uses `xpack.security.enabled=false` and `9200:9200` | No authentication plus publication on all host interfaces | Restrict the lab mapping to `127.0.0.1:9200:9200`; do not expose it externally; enable authentication/TLS for non-isolated use |
| Monitoring ports omit host-IP restrictions | Services may listen beyond the local browser interface | Review and restrict host mappings where appropriate; see R3 |
| `bandit ... || test "$?" -eq 1` | All findings with that exit status are tolerated | Enforce a reviewed policy for findings; do not describe this as a strict gate |
| `archiveArtifacts ... allowEmptyArchive: true` | Missing reports need not fail archiving | Make required reports mandatory when hardening the pipeline |
| Floating image tags and unpinned Python requirements | Rebuilds/audits may change dependency versions | Pin tested inputs or export exact build dependencies before claiming repeatability |
| Final feature-flag edit occurred after scan evidence | Earlier report line numbers and scope are stale for the final revision | Rebuild Jenkins on the final source commit and retain both original and newer reports |
| Selenium is run manually; test file not in Bandit's `app monitoring` targets | Selenium success is separate from Jenkins; test source not included in that scan | Keep that distinction, or deliberately add and evidence a testing stage |
| Selenium passes `--no-sandbox` | Browser sandbox is disabled for the lab session | Keep the container isolated and do not use it for untrusted browsing |

Plan/state sensitivity is general tool guidance ([R1](REFERENCES.md#r1-terraform-state-plans-and-version-control)); the binary plan's contents were not inspected, so no specific credential exposure is asserted. Removing it from the latest commit does not erase earlier history. If a secret was ever committed, rotate it and follow a deliberate history-cleanup process rather than assuming `.gitignore` fixes past disclosure.

## Suggested local-only Elasticsearch change

In `elk/compose.yaml`, change only the Elasticsearch published port to:

```yaml
ports:
  - "127.0.0.1:9200:9200"
```

This is a recommendation, not a patch applied by this pack. Do not recreate Elasticsearch until its sample evidence and any desired data are preserved: the current Compose file has no explicit persistent Elasticsearch volume. Recreating the container can lose the demonstrated index. The service can be stopped after evidence capture with `docker compose -f elk/compose.yaml stop`; do not use `down -v` as routine cleanup.

## What not to claim

Do not claim zero vulnerabilities across the infrastructure, zero Bandit issues, remediation of B104, an automatic push-triggered pipeline, or production-grade security. The submitted evidence shows a working security-scanning demonstration with documented limitations.
