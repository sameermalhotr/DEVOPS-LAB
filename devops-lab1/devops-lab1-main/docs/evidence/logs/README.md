# Execution logs

[Submission checklist](../../CHECKLIST.md) | [Evidence gallery](../../EVIDENCE.md)

## Included now

`jenkins-build-1-excerpt.txt` is a selected transcription of the original screenshot. It is not the complete log and does not prove the build's start cause.

## Export real Jenkins console logs

Use the Windows browser already signed in to the **local** Jenkins instance. For build #1, open:

```text
http://localhost:8080/job/devops-lab1/1/consoleText
```

Save the plain text using the browser's Save function. Review it for passwords, tokens, credential-bearing URLs or other secrets, and then upload it here as `jenkins-build-1-console.txt`.

For the triggered run, replace `1` in that local address with the **actual** build number. Do not assume #2 was automatic until its first lines or build cause establish this. Save its complete log under a matching filename, for example `jenkins-build-2-console.txt` only when #2 is the relevant run.

A useful export shows the start cause, Git source/commit checkout, tests, deployment and final status. If the result is not successful, retain that fact rather than replacing it with a success template. Do not turn off authentication just to export a log.

## Capture fresh environment and Git output

After the pack has been copied into the real repository:

```bash
cd ~/devops-lab1
bash scripts/capture-evidence.sh
```

The script writes timestamped snapshots of environment verification, commit history, branches and Jenkins service status beneath this directory. It does not read the initial administrator password, GitHub CLI token, full environment variables or full Git configuration.

The script will not create Jenkins console logs: those require access to the authenticated local Jenkins browser session. It also does not recreate missing historical installation logs.

## Upload reviewed logs

Use explicit staging to avoid accidentally committing a virtual environment, generated deployment directory or credentials:

```bash
git add docs/evidence/logs
git diff --cached --stat
git commit -m "Add verified environment and Jenkins execution logs"
git push
```

These commands are instructions to run after collecting actual files, not a claim that the logs have already been captured or pushed.
