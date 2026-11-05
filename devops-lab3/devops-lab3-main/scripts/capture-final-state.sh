#!/usr/bin/env bash
# Read-only diagnostic snapshot. Does not install, restart, deploy or alter configuration.
# HTTP GET probes may increment application counters. Review outputs before publishing.
set -uo pipefail
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 1
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
OUT="$ROOT/local-captures/$STAMP"
mkdir -p "$OUT"
FAILURES=0
capture() {
    local name="$1"
    shift
    local status
    {
        printf 'Captured at UTC: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
        printf 'Command:'
        printf ' %q' "$@"
        printf '\n\n'
        "$@"
        status=$?
        printf '\n[exit-code: %s]\n' "$status"
    } > "$OUT/$name.txt" 2>&1
    if [ "$status" -ne 0 ]; then
        printf 'CHECK: %s returned %s\n' "$name" "$status"
        FAILURES=$((FAILURES + 1))
    else
        printf 'OK: %s\n' "$name"
    fi
}
capture git-status git status --short
capture git-history git log -10 --oneline
capture python-version python3 --version
capture ansible-version ansible --version
capture terraform-version terraform version
capture docker-version docker --version
capture compose-version docker compose version
capture monitoring-containers docker compose -f monitoring/compose.yaml ps -a
capture elk-containers docker compose -f elk/compose.yaml ps -a
capture terraform-resource-names terraform -chdir=terraform state list
capture nginx-active systemctl is-active nginx
capture jenkins-active systemctl is-active jenkins
capture app-response curl -fsS --connect-timeout 3 --max-time 8 http://localhost:5002/
capture prometheus-targets curl -fsS --connect-timeout 3 --max-time 8 http://localhost:9090/api/v1/targets
capture elasticsearch-count curl -fsS --connect-timeout 3 --max-time 8 'http://localhost:9200/devops-lab3/_count?pretty'
capture selenium-status curl -fsS --connect-timeout 3 --max-time 8 http://localhost:4444/status
printf '\nSaved to: %s\nChecks with nonzero exit status: %s\n' "$OUT" "$FAILURES"
printf 'These are new diagnostic captures. Review before copying selected files into docs/results.\n'
if [ "$FAILURES" -ne 0 ]; then exit 1; fi
