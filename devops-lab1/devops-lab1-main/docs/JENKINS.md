# Jenkins job, pipeline and automation

[Overview](../README.md) | [Report](../REPORT.md) | [Pipeline source](../Jenkinsfile)

## Recreate the job

These are the configuration values used in the guided setup. Attach a screenshot of the actual saved job settings to complete the configuration evidence.

| Setting | Value |
|---|---|
| Job name | devops-lab1 |
| Job type | Pipeline |
| Definition | Pipeline script from SCM |
| SCM | Git |
| Repository URL | https://github.com/axdy02/devops-lab1.git |
| Credentials | None for the current public repository |
| Branch specifier | */main |
| Script path | Jenkinsfile |
| Pipeline syntax | Declarative |
| Agent declaration | agent any |
| Required agent environment for this implementation | Linux shell, Git, Python 3 and Python virtual-environment support |

In Jenkins, create a Pipeline item, enter these settings and save. Start the first run manually with **Build Now** so Jenkins reads the committed pipeline and establishes its job configuration. Later changes are intended to be detected by the source-polling trigger.

Although the file says `agent any`, its `sh` commands assume a Unix-like agent with the required tools. It is not a portable Windows-agent pipeline without adjustments. The captured agent workspace is `/var/lib/jenkins/workspace/devops-lab1`.

## Build stage

The exact commands currently in the Jenkinsfile are:

```bash
python3 -m venv venv
. venv/bin/activate
pip install -r requirements.txt
python3 -m compileall app.py
```

This prepares the workspace environment and byte-compiles the application. It is not a Python distribution/package build. The current dependency file contains `pytest` without a version constraint, so fresh runs can resolve different package versions.

## Test stage

```bash
. venv/bin/activate
pytest -v
```

The supplied source contains two tests, and the actual Jenkins console shows both passing. The [original console](evidence/screenshots/ss22-jenkins-console.png) reports Python 3.14.4 and pytest 9.1.1 in that run.

## Deploy stage

```bash
mkdir -p deploy
cp app.py deploy/app.py
python3 deploy/app.py
```

This is a local staging and smoke-test step. The destination is beneath the current Jenkins workspace. Running the copied file checks that it produces the expected application output. There is no server process left running after the script exits.

A separate [manual deployment screenshot](evidence/screenshots/ss23-manual-deploy-check.png) exists, but it is not used as proof that Jenkins ran the stage; that proof comes from the Jenkins console itself.

## Trigger and post conditions

The pipeline contains `pollSCM('H/2 * * * *')`. Jenkins polls for a new source revision on a two-minute schedule with a job-based hashed offset. A build is requested when changes are detected, not unconditionally at each poll. The machine, WSL distribution and Jenkins must be available. A webhook is not configured by this line.

The `post` section contains success and failure messages. Only the success message has been observed in the supplied screenshots. These meanings follow the [official Pipeline syntax reference](https://www.jenkins.io/doc/book/pipeline/syntax/).

## Demonstrate the automatic trigger without a manual build

An earlier trigger-test commit already exists. First inspect build #2; do not rerun anything if it already contains the needed cause evidence.

1. Open **devops-lab1 -> #2 -> Console Output** and inspect the first lines.
2. Capture the cause if it says **Started by an SCM change**, together with the checkout commit/remote where possible.
3. Export the full console after checking it for secrets. A success/history screenshot alone is insufficient to establish the cause.

If the earlier run was manual or the evidence is unavailable, create a new real demonstration from the current local checkout:

```bash
cd ~/devops-lab1
git status --short
git pull --ff-only
printf '\nSCM polling demonstration update.\n' >> README.md
git add README.md
git commit -m "Demonstrate SCM-triggered Jenkins build"
git push
```

Make sure any existing local work is safely committed before pulling. Keep Jenkins running, wait for polling and **do not click Build Now**. Once the new build completes, capture its actual cause, checked-out commit and final result. Use the actual build number in filenames; do not label a later build as #2.

The documentation-upload commit itself can also be the source change used for this demonstration. A new dummy commit is unnecessary if that upload already triggers a suitable run.

## Evidence still worth adding

| Evidence | What it proves |
|---|---|
| Saved job settings screenshot | The Git URL, branch and Jenkinsfile path |
| Top of Jenkins Console Output | Trigger cause, source checkout and revision |
| Full raw console export | Unabridged commands, tests, deployment and outcome |
| Git Polling Log, where available | Jenkins checking source changes and scheduling a run |
| Stage view, if available | Optional visual summary of stage completion |

Use [the log export guide](evidence/logs/README.md). Do not disable authentication or expose port 8080 publicly just so an evaluator can access the local service.

## Optional improvements, not implemented in the submitted pipeline

A later iteration could pin dependencies, generate JUnit XML, publish test reports, archive the copied artifact, constrain concurrency, and deploy to a separate directory or supervised service. These are improvement ideas, not capabilities claimed for the present Jenkinsfile. The provided documentation pack does not alter the working pipeline or invent evidence for these features.
