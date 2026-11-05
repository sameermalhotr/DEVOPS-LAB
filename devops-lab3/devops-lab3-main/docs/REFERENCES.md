# References and provenance

## Primary lab evidence

The results in this repository are grounded in [the original 17-page Word document](source/Lab3-Evidence.docx), its [image gallery and source mapping](EVIDENCE.md), the user's terminal output, and the existing [GitHub repository](https://github.com/axdy02/devops-lab3). The source images are execution evidence; the generated report is an interpretation of them.

The GitHub tree was reviewed during preparation on November 5, 2026. Its tree SHA was `c7d54f772e7b07619550ef550615c37e7996a288` (tree ID, not a commit ID). Reviewed files include `.gitignore`, `Jenkinsfile`, `terraform/main.tf`, both Compose files, `monitoring/app.py` `tests/test_selenium.py` and the header of `LICENSE.txt`. Additional file presence was checked with the recursive tree. No repository write was performed while preparing the ZIP.

## Supplementary official guidance

These sources explain tool behavior and support review recommendations. They do not prove that any extra experiment or remediation was executed. Checked November 5, 2026.

### R1. Terraform state, plans and version control

[HashiCorp configuration style guidance](https://developer.hashicorp.com/terraform/language/style) and [sensitive-data guidance](https://developer.hashicorp.com/terraform/language/manage-sensitive-data).

Keep configuration and the provider lock file; exclude local state, provider working directories and saved binary plans. State and plans can contain sensitive data.

### R2. Docker Compose networking

[Docker Compose networking](https://docs.docker.com/compose/how-tos/networking/).

Compose service names resolve to containers on the shared network. A host process does not automatically inherit a stopped container's service identity.

### R3. Docker published ports

[Docker port publishing](https://docs.docker.com/engine/network/port-publishing/).

Omitting a host address publishes the port on host interfaces; explicit loopback bindings limit host-side access. Review actual mappings rather than assuming localhost-only exposure from a browser URL.

### R4. Bandit B104

[Bandit B104 documentation](https://bandit.readthedocs.io/en/latest/plugins/b104_hardcoded_bind_all_interfaces.html).

The rule identifies possible binding to all network interfaces. The recorded severity/confidence comes from the actual report.

### R5. pip-audit

[Maintainer documentation on PyPI](https://pypi.org/project/pip-audit/).

The tool checks Python dependencies for known vulnerabilities. The lab's audit snapshot is not a universal security guarantee.

### R6. Git ignore behavior

[Git gitignore documentation](https://git-scm.com/docs/gitignore).

Ignore rules do not retroactively untrack files. The cleanup command therefore explicitly removes the plan from Git's index while retaining it locally.
