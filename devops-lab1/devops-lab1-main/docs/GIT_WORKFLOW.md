# Git workflow, branches and commit history

[Overview](../README.md) | [Report](../REPORT.md) | [Git evidence](EVIDENCE.md#q2-version-control)

## Demonstrated sequence

This section reconstructs the workflow already completed. It is not a script to rerun over the existing repository.

```bash
cd ~
mkdir devops-lab1
cd devops-lab1
git init
git branch -M main
# app.py and README.md were created here.
git add app.py README.md
git commit -m "Initial Python application setup"

git switch -c feature-tests
# test_app.py, requirements.txt and .gitignore were added here.
python3 -m venv venv
. venv/bin/activate
pip install -r requirements.txt
pytest -v
git add .gitignore requirements.txt test_app.py
git commit -m "Add unit tests with pytest"
git switch main
git merge feature-tests

git switch -c docs-update
# The CI/CD stages section was added to README.md here.
git add README.md
git commit -m "Document CI/CD pipeline stages"
git switch main
git merge docs-update
git log --oneline --graph --decorate --all
```

The repository's `.gitignore` excludes the virtual environment, Python caches and compiled bytecode. Staging named files avoids accidentally including generated deployment output or credentials.

## GitHub remote and authentication

```bash
git remote add origin https://github.com/axdy02/devops-lab1.git
git remote -v
git push -u origin main
```

The practical used GitHub CLI browser authentication after the initial push requested credentials. The [authentication screenshot](evidence/screenshots/ss18-github-auth.png) masks the token. Never commit the local GitHub CLI credential file or paste an access token into the repository URL.

The local `gh` authentication belongs to the developer's Linux user. It is separate from Jenkins's service-account configuration. The public repository can be read without transferring the developer's authentication to Jenkins.

## Recorded commits before this expanded documentation

| Order | Commit | Purpose |
|---|---|---|
| 1 | [2719c1e](https://github.com/axdy02/devops-lab1/commit/2719c1e) | Initial Python application setup |
| 2 | [1235e08](https://github.com/axdy02/devops-lab1/commit/1235e08) | Add unit tests with pytest |
| 3 | [548ad41](https://github.com/axdy02/devops-lab1/commit/548ad41) | Document CI/CD pipeline stages |
| 4 | [8b7f655](https://github.com/axdy02/devops-lab1/commit/8b7f655) | Add Jenkins CI/CD pipeline |
| 5 | [c02a681](https://github.com/axdy02/devops-lab1/commit/c02a681) | Test automated Jenkins trigger |
| 6 | [a5b3788](https://github.com/axdy02/devops-lab1/commit/a5b3788) | Add Lab 1 command documentation |
| 7 | [5071511](https://github.com/axdy02/devops-lab1/commit/5071511) | Add Lab 1 CI/CD workflow report |

The first three short hashes are also visible in the local history screenshots. The review baseline is commit `50715110d0a0c622566ec0175ddf0d73c4560bd6`. Later documentation commits should be added normally, not used to replace this history.

## Why the merge graph is linear

The feature merge output explicitly says `Fast-forward`. This records a valid merge by advancing `main` to the feature branch's tip. It does not produce a two-parent merge commit. Do not fabricate a non-linear graph or redo the exercise simply to make the history look more complex.

## Local branches versus GitHub branches

The captured local history includes `feature-tests` and `docs-update`. The GitHub branch listing at the review baseline contains only `main`, because `git push -u origin main` does not publish every local branch.

Publishing the already-existing feature branches is optional but makes them visible to a GitHub-only evaluator:

```bash
cd ~/devops-lab1
git branch --list
# Run only if both names above still exist locally:
git push origin feature-tests docs-update
```

There is no need to delete, recreate, force-push or rewrite branches. The existing screenshots already demonstrate branch creation and the merge operation.

## Capture current history for the submission

The provided helper records fresh Git output from the real repository:

```bash
cd ~/devops-lab1
bash scripts/capture-evidence.sh
```

It does not change Git identity or create commits. Review the generated logs before staging them. The captured history is the state before the subsequent evidence-upload commit; that ordering is normal.
