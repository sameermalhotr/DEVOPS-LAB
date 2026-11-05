# Submission readiness and remaining evidence

[Overview](../README.md) | [Report](../REPORT.md) | [Gallery](EVIDENCE.md)

## Confirmed by the supplied material

- [x] Ubuntu, Git, Java and Jenkins installation verification.
- [x] Running Jenkins service and configured dashboard.
- [x] Global Git name and email configuration.
- [x] Git initialization, commits, branch creation, fast-forward merge and local decorated history.
- [x] Successful push and application files on GitHub.
- [x] Two tests pass in both local and Jenkins screenshots.
- [x] The repository Jenkinsfile defines Build, Test, Deploy, SCM polling and post conditions.
- [x] Jenkins build #1 executes the local Deploy stage and ends with SUCCESS.
- [x] Build history shows both #1 and #2 successful.
- [x] Command and report files were committed and pushed before this documentation expansion.

A checked item means evidence exists, not that the faculty has awarded marks.

## 1. Attach direct trigger and checkout evidence

**This is the most important remaining evidence gap.**

The current screenshot of build #2 shows success but not its start cause. Inspect **Jenkins -> devops-lab1 -> #2 -> Console Output**, at the top. Capture the actual line such as `Started by an SCM change` and the checked-out GitHub revision. If the source checkout is further down, capture that separately.

Save new screenshots in `docs/evidence/screenshots/`, for example:

```text
ss30-scm-trigger-cause.png
ss31-github-checkout.png
ss32-job-configuration.png
```

These are suggested filenames, not files that already exist in the documentation pack. Use the actual build number and explain it in the gallery. Also attach the saved job configuration showing the Git URL, `*/main`, and `Jenkinsfile`.

- [ ] Direct SCM-trigger cause or unambiguous polling-log evidence attached.
- [ ] GitHub checkout and commit visible in a screenshot or full raw log.
- [ ] Saved Jenkins job configuration captured.

If build #2 was started manually, do not label it automatic. Let a new pushed commit trigger a new build, then collect the real evidence. The docs-upload commit can serve as that change.

## 2. Add actual logs

The instructions ask for logs as well as screenshots. The pack includes a selected transcription of the visible console, clearly marked as an excerpt, but not a complete raw export.

- [ ] Export build #1's complete Console Output to `docs/evidence/logs/jenkins-build-1-console.txt`.
- [ ] Export the actually SCM-triggered build's complete log using its real number in the filename.
- [ ] Run `bash scripts/capture-evidence.sh` in the real Ubuntu repository and upload the generated verification/history files.

Detailed steps are in [the log guide](evidence/logs/README.md). Inspect logs for credentials before publishing. Do not use raw shell-history dumps that may include tokens or passwords.

## 3. Publish the documentation and check the single-link submission

- [ ] Copy/upload all files from the pack's `github-files` directory into the existing repository root.
- [ ] Keep the existing application, tests and Jenkinsfile; do not replace the Git repository or history.
- [ ] Open the README, report and evidence gallery on GitHub and confirm images load.
- [ ] Confirm the final documentation/evidence commit is on `main`.
- [ ] Confirm the faculty can read the repository; the recorded repository was public.
- [ ] Check whether the prescribed report template requires a roll number, section or other metadata; add only the correct details.
- [ ] Complete any separate lab feedback/session requirements in the college portal.

The pack intentionally does not guess the student's roll number or certify instructor approval.

## 4. Confirm the deployment/environment interpretation

The implemented deployment is a local workspace copy-and-run demonstration. It is correctly documented that way. The assignment text does not specify a separate deployment target, so acceptance of this minimal demonstration is an instructor decision.

- [ ] Confirm the approved lab environment includes the WSL2 setup used here.
- [ ] Confirm the instructor accepts local staging/execution, or extend the practical to the separately required target and collect new evidence.

No cloud account, Docker image, domain, public website or hosted Jenkins is explicitly required by the supplied Lab 1 tasks. Do not add these merely to decorate the submission. If the instructor requires a running application deployment, documentation alone is not a substitute for implementing it.

## Optional quality improvements

These are not established missing requirements in the supplied task:

- Publish the existing `feature-tests` and `docs-update` branches after confirming they exist locally.
- Pin the test dependency versions, then rerun the pipeline and record the new result.
- Add JUnit reports, artifact archiving and an independent deployment destination.
- Add the local generated `deploy/` directory to `.gitignore` if it is not intended to be tracked. Prefer explicit file staging regardless.
- Demonstrate a test failure and recovery only if requested; currently only successful execution is evidenced.

## What not to redo

Do not reinstall Jenkins, rebuild the repository, fabricate merge commits, reset history or take every installation screenshot again. The existing 29 originals and the full-size Jenkins console provide usable evidence. Finish the missing cause/configuration/log records instead.
