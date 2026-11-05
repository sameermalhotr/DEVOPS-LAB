# Practical evidence gallery

[Overview](../README.md) | [Complete report](../REPORT.md) | [Checklist](CHECKLIST.md)

The 29 numbered images below are the original embedded PNGs extracted from **Devops lab 1 evidence.docx**, without resampling or altered text. The two letter-suffixed images are labelled detail crops of originals, included for readability. The original numbering follows document order and may differ from earlier chat screenshot labels.

Each caption states what the image actually establishes. Open an image to view it at its native size. A screenshot of a successful build does not by itself establish the trigger cause.

## Quick access

- [Jenkins tests, deployment and success (readable crop)](evidence/screenshots/ss22a-console-detail.png)
- [Original full Jenkins console](evidence/screenshots/ss22-jenkins-console.png)
- [Two successful builds](evidence/screenshots/ss25-builds-successful.png)
- [Remaining trigger/checkout evidence](CHECKLIST.md#1-attach-direct-trigger-and-checkout-evidence)
- [Screenshot source and integrity manifest](evidence/manifest.json)

## Q1 installation and configuration

### SS01 - Ubuntu environment

**Requirement:** Q1 | **Original document page:** 1

Ubuntu 26.04.1 LTS (resolute) is shown by lsb_release -a.

<details>
<summary>Open screenshot SS01</summary>

![SS01: Ubuntu environment](evidence/screenshots/ss01-ubuntu-version.png)

[View original-size PNG](evidence/screenshots/ss01-ubuntu-version.png)

</details>

### SS02 - Git installation

**Requirement:** Q1 | **Original document page:** 1

git --version reports Git 2.53.0.

<details>
<summary>Open screenshot SS02</summary>

![SS02: Git installation](evidence/screenshots/ss02-git-version.png)

[View original-size PNG](evidence/screenshots/ss02-git-version.png)

</details>

### SS03 - Java installation

**Requirement:** Q1 | **Original document page:** 1

java -version reports OpenJDK 21.0.12.1.

<details>
<summary>Open screenshot SS03</summary>

![SS03: Java installation](evidence/screenshots/ss03-java-version.png)

[View original-size PNG](evidence/screenshots/ss03-java-version.png)

</details>

### SS04 - systemd health

**Requirement:** Q1 | **Original document page:** 1

systemctl is-system-running reports running.

<details>
<summary>Open screenshot SS04</summary>

![SS04: systemd health](evidence/screenshots/ss04-systemd-running.png)

[View original-size PNG](evidence/screenshots/ss04-systemd-running.png)

</details>

### SS05 - Jenkins installation

**Requirement:** Q1 | **Original document page:** 1

jenkins --version reports 2.580.1.

<details>
<summary>Open screenshot SS05</summary>

![SS05: Jenkins installation](evidence/screenshots/ss05-jenkins-version.png)

[View original-size PNG](evidence/screenshots/ss05-jenkins-version.png)

</details>

### SS06 - Jenkins service

**Requirement:** Q1 | **Original document page:** 1

The service is enabled and active (running).

<details>
<summary>Open screenshot SS06</summary>

![SS06: Jenkins service](evidence/screenshots/ss06-jenkins-service.png)

[View original-size PNG](evidence/screenshots/ss06-jenkins-service.png)

</details>

### SS07 - Jenkins initial setup

**Requirement:** Q1 | **Original document page:** 1

The Unlock Jenkins page is visible. The password field is empty.

<details>
<summary>Open screenshot SS07</summary>

![SS07: Jenkins initial setup](evidence/screenshots/ss07-jenkins-unlock.png)

[View original-size PNG](evidence/screenshots/ss07-jenkins-unlock.png)

</details>

### SS08 - Jenkins dashboard

**Requirement:** Q1 | **Original document page:** 2

The configured Jenkins dashboard is accessible in the browser.

<details>
<summary>Open screenshot SS08</summary>

![SS08: Jenkins dashboard](evidence/screenshots/ss08-jenkins-dashboard.png)

[View original-size PNG](evidence/screenshots/ss08-jenkins-dashboard.png)

</details>

### SS09 - Git global configuration

**Requirement:** Q1 | **Original document page:** 2

The screenshot shows user.name=axdy02 and a configured user.email. The original email remains visible.

<details>
<summary>Open screenshot SS09</summary>

![SS09: Git global configuration](evidence/screenshots/ss09-git-global-config.png)

[View original-size PNG](evidence/screenshots/ss09-git-global-config.png)

</details>

## Q2 version control

### SS10 - Repository initialization

**Requirement:** Q2 | **Original document page:** 2

git status shows main and No commits yet.

<details>
<summary>Open screenshot SS10</summary>

![SS10: Repository initialization](evidence/screenshots/ss10-git-initialized.png)

[View original-size PNG](evidence/screenshots/ss10-git-initialized.png)

</details>

### SS11 - First commit

**Requirement:** Q2 | **Original document page:** 2

The initial Python application and README commit is shown, followed by git log.

<details>
<summary>Open screenshot SS11</summary>

![SS11: First commit](evidence/screenshots/ss11-first-commit.png)

[View original-size PNG](evidence/screenshots/ss11-first-commit.png)

</details>

### SS12 - Feature branch

**Requirement:** Q2 | **Original document page:** 2

git switch -c feature-tests creates the branch and git branch lists it.

<details>
<summary>Open screenshot SS12</summary>

![SS12: Feature branch](evidence/screenshots/ss12-feature-branch.png)

[View original-size PNG](evidence/screenshots/ss12-feature-branch.png)

</details>

### SS13 - Local unit tests

**Requirement:** Q2, Q4 | **Original document page:** 2

Both test_add and test_add_negative_numbers pass locally. This is not a Jenkins run.

<details>
<summary>Open screenshot SS13</summary>

![SS13: Local unit tests](evidence/screenshots/ss13-local-tests.png)

[View original-size PNG](evidence/screenshots/ss13-local-tests.png)

</details>

### SS14 - Feature commit history

**Requirement:** Q2 | **Original document page:** 3

The feature-tests branch contains the unit-test commit ahead of main.

<details>
<summary>Open screenshot SS14</summary>

![SS14: Feature commit history](evidence/screenshots/ss14-feature-commit.png)

[View original-size PNG](evidence/screenshots/ss14-feature-commit.png)

</details>

### SS15 - Feature merge

**Requirement:** Q2 | **Original document page:** 3

git merge feature-tests completes as a fast-forward; the history includes both commits.

<details>
<summary>Open screenshot SS15</summary>

![SS15: Feature merge](evidence/screenshots/ss15-feature-merge.png)

[View original-size PNG](evidence/screenshots/ss15-feature-merge.png)

</details>

### SS16 - Local branch history

**Requirement:** Q2, Q6 | **Original document page:** 3

main, docs-update and feature-tests references appear in the local decorated history.

<details>
<summary>Open screenshot SS16</summary>

![SS16: Local branch history](evidence/screenshots/ss16-local-history.png)

[View original-size PNG](evidence/screenshots/ss16-local-history.png)

</details>

### SS17 - GitHub repository created

**Requirement:** Q2 | **Original document page:** 3

The empty GitHub repository setup page is shown.

<details>
<summary>Open screenshot SS17</summary>

![SS17: GitHub repository created](evidence/screenshots/ss17-empty-github-repo.png)

[View original-size PNG](evidence/screenshots/ss17-empty-github-repo.png)

</details>

### SS18 - GitHub authentication

**Requirement:** Q2 | **Original document page:** 3

gh auth status reports the axdy02 account. The token is masked in the source screenshot.

<details>
<summary>Open screenshot SS18</summary>

![SS18: GitHub authentication](evidence/screenshots/ss18-github-auth.png)

[View original-size PNG](evidence/screenshots/ss18-github-auth.png)

</details>

### SS19 - Successful GitHub push

**Requirement:** Q2 | **Original document page:** 4

git push -u origin main succeeds and configures upstream tracking.

<details>
<summary>Open screenshot SS19</summary>

![SS19: Successful GitHub push](evidence/screenshots/ss19-github-push.png)

[View original-size PNG](evidence/screenshots/ss19-github-push.png)

</details>

### SS20 - Source files on GitHub

**Requirement:** Q2 | **Original document page:** 4

The initial source, tests, requirements and README appear on GitHub with three commits.

<details>
<summary>Open screenshot SS20</summary>

![SS20: Source files on GitHub](evidence/screenshots/ss20-github-source.png)

[View original-size PNG](evidence/screenshots/ss20-github-source.png)

</details>

## Q3-Q5 pipeline testing and local deployment

### SS21 - Pipeline file on GitHub

**Requirement:** Q3, Q4 | **Original document page:** 5

Jenkinsfile is present in the repository after the pipeline commit.

<details>
<summary>Open screenshot SS21</summary>

![SS21: Pipeline file on GitHub](evidence/screenshots/ss21-github-jenkinsfile.png)

[View original-size PNG](evidence/screenshots/ss21-github-jenkinsfile.png)

</details>

### SS22 - Jenkins build 1 console

**Requirement:** Q3, Q4, Q5 | **Original document page:** 6

Build #1 shows two passing tests, the Deploy commands and application output, the success post action, and Finished: SUCCESS. The top of the checkout log is outside this screenshot.

<details>
<summary>Open screenshot SS22</summary>

![SS22: Jenkins build 1 console](evidence/screenshots/ss22-jenkins-console.png)

[View original-size PNG](evidence/screenshots/ss22-jenkins-console.png)

</details>

**Readable detail crop (SS22A):**

![Original console detail: tests, deployment and success](evidence/screenshots/ss22a-console-detail.png)

The crop changes the viewport only; the full original remains linked above.

### SS23 - Manual deployment check

**Requirement:** Q5 | **Original document page:** 6

The developer terminal copies and executes deploy/app.py. This is a manual check; Jenkins-run deployment is separately evidenced by SS22.

<details>
<summary>Open screenshot SS23</summary>

![SS23: Manual deployment check](evidence/screenshots/ss23-manual-deploy-check.png)

[View original-size PNG](evidence/screenshots/ss23-manual-deploy-check.png)

</details>

### SS24 - Second build appearing

**Requirement:** Q3, Q5 | **Original document page:** 6

The Build Time Trend view includes a second build. This view alone does not identify its trigger cause.

<details>
<summary>Open screenshot SS24</summary>

![SS24: Second build appearing](evidence/screenshots/ss24-build-2-running.png)

[View original-size PNG](evidence/screenshots/ss24-build-2-running.png)

</details>

### SS25 - Two successful builds

**Requirement:** Q3, Q5 | **Original document page:** 7

The Build Time Trend view shows builds #1 and #2 successful, with durations of 11 seconds and 5.4 seconds respectively. It does not show the trigger cause.

<details>
<summary>Open screenshot SS25</summary>

![SS25: Two successful builds](evidence/screenshots/ss25-builds-successful.png)

[View original-size PNG](evidence/screenshots/ss25-builds-successful.png)

</details>

**Readable result crop (SS25A):**

![Original successful-build history detail](evidence/screenshots/ss25a-build-results-detail.png)

The trigger-cause line is not part of this view.

## Q6-Q7 command documentation and report

### SS26 - Command documentation commit

**Requirement:** Q6 | **Original document page:** 7

commands.txt is committed and pushed successfully.

<details>
<summary>Open screenshot SS26</summary>

![SS26: Command documentation commit](evidence/screenshots/ss26-commands-commit.png)

[View original-size PNG](evidence/screenshots/ss26-commands-commit.png)

</details>

### SS27 - Command documentation on GitHub

**Requirement:** Q6 | **Original document page:** 8

commands.txt is visible on GitHub; the README also contains the trigger-verification statement. That statement is not independent trigger evidence.

<details>
<summary>Open screenshot SS27</summary>

![SS27: Command documentation on GitHub](evidence/screenshots/ss27-commands-on-github.png)

[View original-size PNG](evidence/screenshots/ss27-commands-on-github.png)

</details>

### SS28 - Report commit

**Requirement:** Q7 | **Original document page:** 9

REPORT.md is committed and pushed successfully.

<details>
<summary>Open screenshot SS28</summary>

![SS28: Report commit](evidence/screenshots/ss28-report-commit.png)

[View original-size PNG](evidence/screenshots/ss28-report-commit.png)

</details>

### SS29 - Report on GitHub

**Requirement:** Q6, Q7 | **Original document page:** 10

The repository contains REPORT.md, commands.txt, Jenkinsfile and the application files.

<details>
<summary>Open screenshot SS29</summary>

![SS29: Report on GitHub](evidence/screenshots/ss29-report-on-github.png)

[View original-size PNG](evidence/screenshots/ss29-report-on-github.png)

</details>

## New evidence to add

After collecting the items in the [checklist](CHECKLIST.md), add the real screenshots and links here. No blank screenshots, fabricated output or placeholder success logs have been supplied. The original email remains visible in SS09, while the authentication token in SS18 is already masked in the source. Review the email-visibility choice before public upload.
