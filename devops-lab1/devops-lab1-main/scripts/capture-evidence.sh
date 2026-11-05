#!/usr/bin/env bash
# Capture real, non-secret verification output from the student's lab checkout.
# No application, pipeline, Git configuration or service configuration is changed.
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || {
    printf 'Run this inside the existing devops-lab1 Git repository.\n' >&2
    exit 1
}
cd "$ROOT"
if [[ ! -f app.py || ! -f Jenkinsfile ]]; then
    printf 'Expected app.py and Jenkinsfile in the repository root. Stopping.\n' >&2
    exit 1
fi
STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
OUT="$ROOT/docs/evidence/logs"
mkdir -p "$OUT"

record() {
    local rc=0
    printf '\n$'
    printf ' %q' "$@"
    printf '\n'
    "$@" 2>&1 || rc=$?
    if (( rc != 0 )); then
        printf '[Command exit status: %s; retain this diagnostic rather than editing it away.]\n' "$rc"
    fi
}

{
    printf 'ENVIRONMENT SNAPSHOT (fresh output, not an installation transcript)\n'
    printf 'Captured UTC: %s\n' "$STAMP"
    record lsb_release -a
    record git --version
    record java -version
    record python3 --version
    record jenkins --version
    record ps -p 1 -o comm=
    record systemctl is-system-running
    record git config --global --get user.name
    printf '\nGit email value deliberately not printed by this helper.\n'
    if git config --global --get user.email >/dev/null 2>&1; then
        printf 'A global user.email entry is configured.\n'
    else
        printf 'No global user.email entry found.\n'
    fi
} > "$OUT/environment-$STAMP.txt"

{
    printf 'GIT HISTORY SNAPSHOT\nCaptured UTC: %s\n' "$STAMP"
    record git rev-parse HEAD
    record git log --oneline --graph --decorate --all
} > "$OUT/git-history-$STAMP.txt"

{
    printf 'GIT BRANCH SNAPSHOT\nCaptured UTC: %s\n' "$STAMP"
    record git branch -avv
} > "$OUT/git-branches-$STAMP.txt"

{
    printf 'JENKINS SERVICE SNAPSHOT\nCaptured UTC: %s\n' "$STAMP"
    # --lines=0 avoids including journal lines that may contain setup secrets.
    record systemctl status jenkins --no-pager --lines=0
    record systemctl is-enabled jenkins
    record systemctl is-active jenkins
} > "$OUT/jenkins-service-$STAMP.txt"

printf 'Saved four fresh evidence logs under: %s\n' "$OUT"
printf 'Review the files before committing. Diagnostics are preserved, not hidden.\n'
printf 'Export the full Jenkins console separately from the authenticated browser.\n'
