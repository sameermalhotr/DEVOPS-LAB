# Helper scripts

These scripts are newly supplied conveniences. Their presence is not evidence that they were run during the original lab.

`python3 scripts/check-submission.py` checks required files, Markdown local file links and known risky tracked filenames. It does not scan file contents/history for secrets or prove that any service is running.

`bash scripts/capture-final-state.sh` records actual local version checks, named lab container status, Terraform resource names and selected HTTP/status responses. It performs no installs or configuration changes, but HTTP requests can increment the app counter. Captures go into ignored `local-captures/`; review before publishing. A nonzero result is kept, not disguised as a pass.

Neither script needs root. Do not use sudo to run the whole project merely to hide permission problems. Some diagnostic checks may be unavailable if a service is stopped, which the output will record.
