# Environment setup and verification

[Overview](../README.md) | [Report](../REPORT.md) | [Evidence](EVIDENCE.md)

## Observed setup

The work uses Windows with an Ubuntu WSL2 distribution. Jenkins is installed in Ubuntu and managed by systemd. The successful evidence is from the `user@EAGLE` environment, not the earlier `root@PREDATOR` session.

Observed versions are Ubuntu 26.04.1 LTS, Git 2.53.0, OpenJDK 21.0.12.1 and Jenkins 2.580.1. They come from [SS01-SS06](EVIDENCE.md#q1-installation-and-configuration). The commands below are a reproduction guide. Do not reinstall a working environment solely to reproduce installation screenshots.

## 1. Open the existing Ubuntu distribution

Run in **Windows PowerShell**:

```powershell
wsl -l -v
wsl -d Ubuntu
```

Run in **Ubuntu**:

```bash
cd ~
lsb_release -a
ps -p 1 -o comm=
systemctl is-system-running
```

The captured systemd result is `running`. The lab requires an authorized environment; confirm WSL2 is accepted by the instructor when this is used for the assessed session.

## 2. Install prerequisites on a new lab environment

These commands modify system packages and may require the Ubuntu password. On the already completed environment, verification is enough.

```bash
sudo apt update
sudo apt install -y git python3-venv openjdk-21-jre-headless fontconfig wget ca-certificates
```

The historical workflow also ran `sudo apt upgrade -y`. That is a system-wide package upgrade, not a prerequisite to repeat every time the project is used.

```bash
git --version
java -version
```

Java runs Jenkins; Python runs the sample application. Do not infer that the application has to be written in Java because Jenkins uses Java.

## 3. Jenkins repository and installation

The lab used the Jenkins LTS APT repository. The following is the documented 2026-key setup, consistent with the [official Jenkins Linux installation guide](https://www.jenkins.io/doc/book/installing/linux/). Consult that guide again for a future fresh install because repository keys and supported runtimes can change.

```bash
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install -y jenkins
sudo systemctl enable --now jenkins
jenkins --version
systemctl status jenkins --no-pager
```

The captured outcome is an enabled, active Jenkins service. Do not disable authentication or relax system permissions to simplify a lab screenshot.

## 4. Complete the browser wizard

Open `http://localhost:8080` from the Windows browser. For a fresh installation, obtain the initial password **locally**:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Never capture this command's password output in public evidence. Use it to unlock Jenkins, install suggested plugins and create the first administrator account. The captured blank unlock page and resulting dashboard are [SS07](evidence/screenshots/ss07-jenkins-unlock.png) and [SS08](evidence/screenshots/ss08-jenkins-dashboard.png).

## 5. Git configuration

For a new environment, set the name and email before the first commit. The historical screenshot shows `user.name=axdy02`. Use the real email associated with the intended GitHub attribution, or an appropriate GitHub no-reply address. The placeholder below is not a value to copy unchanged.

```bash
git config --global user.name "axdy02"
git config --global user.email "<YOUR_GIT_EMAIL>"
git config --global --get user.name
git config --global --get user.email
```

[SS09](evidence/screenshots/ss09-git-global-config.png) is the actual captured configuration. Its email is visible; review that privacy choice before publishing.

## 6. Restarting the working setup

Start the existing distribution, then check Jenkins rather than reinstalling it:

```powershell
wsl -d Ubuntu
```

```bash
sudo systemctl start jenkins
systemctl is-active jenkins
```

Keep the machine and WSL environment available during the polling demonstration. A shutdown or suspension prevents the intended background polling from running normally.

## Troubleshooting notes

| Symptom | Check |
|---|---|
| Jenkins page unavailable | Check the service status; read `journalctl -u jenkins -n 60 --no-pager` locally |
| No Java command | Verify/install the supported Java runtime before restarting Jenkins |
| Virtual environment creation fails | Ensure `python3-venv` is installed in the Ubuntu environment used by the agent |
| systemd transport error after a WSL package upgrade | Restart the distribution and recheck systemd; do not assume every `degraded` state is harmless |
| Build cannot find source files | Verify the repository, `*/main` and `Jenkinsfile` settings; inspect checkout output |

`wsl --shutdown` stops all WSL distributions, including Docker's WSL backend when active. Save work and stop dependent workloads before using it as a troubleshooting step. It is not needed to run this project normally.
