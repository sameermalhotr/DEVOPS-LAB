#!/usr/bin/env python3
"""Read-only file/link/tracked-artifact check; does not certify the lab experiments."""
from pathlib import Path
import re
import subprocess
import sys
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parent.parent
REQUIRED = (
    ".gitignore", "README.md", "REPORT.md", "commands.txt", "Jenkinsfile",
    "ansible/inventory.ini", "ansible/deploy.yml", "app/index.html",
    "terraform/main.tf", "terraform/.terraform.lock.hcl",
    "monitoring/app.py", "monitoring/Dockerfile", "monitoring/compose.yaml",
    "monitoring/prometheus.yml", "monitoring/requirements.txt",
    "elk/compose.yaml", "elk/logstash/pipeline/logstash.conf",
    "requirements.txt", "bandit-report.txt", "pip-audit-report.json",
    "tests/test_selenium.py", "docs/EVIDENCE.md", "docs/evidence/manifest.csv",
    "docs/source/Lab3-Evidence.docx",
)
errors = []
for name in REQUIRED:
    if not (ROOT / name).is_file():
        errors.append(f"Missing required file: {name}")

# Check Markdown local targets, not external URLs or anchor existence.
md_files = [ROOT / "README.md", ROOT / "REPORT.md", *sorted((ROOT / "docs").rglob("*.md"))]
for md in md_files:
    if not md.is_file():
        continue
    text = re.sub(r"```.*?```", "", md.read_text(encoding="utf-8"), flags=re.S)
    for target in re.findall(r"\]\(([^)\s]+)\)", text):
        parts = urlsplit(target)
        if parts.scheme or parts.netloc or not parts.path:
            continue
        local = (md.parent / unquote(parts.path)).resolve()
        if not local.exists():
            errors.append(f"Broken local link in {md.relative_to(ROOT)}: {target}")

try:
    result = subprocess.run(["git", "ls-files", "-z"], cwd=ROOT, text=True,
                            capture_output=True, check=True)
except (FileNotFoundError, subprocess.CalledProcessError) as exc:
    errors.append("Could not read the Git index. Run this inside the existing repository: " + str(exc))
else:
    for name in result.stdout.split("\0"):
        if not name:
            continue
        path = Path(name)
        base = path.name
        forbidden = (
            any(part in {".venv", "venv", ".jenkins-venv", ".terraform"} for part in path.parts)
            or base == "tfplan" or base.startswith("tfplan.") or base.endswith(".tfplan")
            or base.endswith(".tfstate") or ".tfstate." in base
            or base == ".env" or (base.startswith(".env.") and base != ".env.example")
            or base.endswith((".pem", ".key", ".tfvars", ".tfvars.json"))
            or base == "terraform.zip"
        )
        if forbidden:
            errors.append(f"Review/untrack local or sensitive artifact: {name}")

if errors:
    for error in sorted(set(errors)):
        print("CHECK:", error)
    print("No files were changed. This checks names/links, not file contents or Git history for secrets.")
    sys.exit(1)
print("PASS: Required files and local Markdown targets exist; no listed forbidden file patterns are tracked.")
print("This is not a secret scan, a runtime test or a guarantee of assignment completion.")
