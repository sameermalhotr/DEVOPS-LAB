# Sources, review baseline and evidence integrity

[Overview](../README.md) | [Gallery](EVIDENCE.md) | [Checklist](CHECKLIST.md)

## Primary sources

1. The student's [Lab 1 task screenshot](requirements/lab1-tasks.png) and [general instruction screenshot](requirements/general-instructions.png).
2. The uploaded **Devops lab 1 evidence.docx**, containing 29 embedded PNG images across 10 rendered pages. All 29 original image files are included under `evidence/screenshots`.
3. The live repository **axdy02/devops-lab1**, read at baseline commit `50715110d0a0c622566ec0175ddf0d73c4560bd6`. The reviewed root contained `.gitignore`, `Jenkinsfile`, `README.md`, `REPORT.md`, `app.py`, `commands.txt`, `requirements.txt` and `test_app.py`.
4. Repository commit and branch metadata. Only `main` was listed remotely at that baseline; local feature-branch evidence is in the supplied screenshots.

## What was and was not verified

The source code and Jenkinsfile were inspected, and the original full-resolution screenshots were reviewed. Those screenshots verify historical results. The documentation generator did not log in to the student's local Jenkins instance or rerun its jobs. A repository read does not establish the current availability of a service on the student's computer.

Job settings are documented from the guided setup. They still need a saved-configuration screenshot or export to serve as direct evidence. SCM polling is visible in source; the actual trigger cause is not visible in the supplied screenshots.

## Authenticity and transformations

The original screenshot bytes were extracted without changes. `evidence/manifest.json` records their SHA-256 values, source document page/part and pixel dimensions. SS22A and SS25A are rectangular detail crops of SS22 and SS25. No application output, status indicator or result was generated or changed inside the images.

The console excerpt is a selected manual transcription of readable screenshot lines. It is not labelled as a full raw log. Fresh log capture is intentionally left to the real lab environment.

The supplied screenshots contain a visible Git email address in SS09. The token shown by GitHub CLI in SS18 is already masked. No unmasked administrator password or token is intentionally included. Review any newly exported logs and screenshots before public upload.

## Source snapshot details

| Source path | Git blob SHA reviewed |
|---|---|
| Jenkinsfile | ce9c0653cffb67af6d7e4f3394be237b566c805b |
| app.py | e3244426d6926e9d4052b419ab4edbc0c7155f5c |
| test_app.py | 97efa94ff74c90fe7f06b1f49310f224f62ad1a6 |
| requirements.txt | e079f8a6038dd2dc8512967540f96ee0de172067 |
| .gitignore | 2f326ed1191b0081fff054f3afa8c28726b01029 |

The documentation pack updates documentation and adds evidence/capture helpers. It does not replace those application/pipeline files. The old report and command reference remain accessible in the repository's earlier commits after the updates are committed normally.

## External technical references

These references explain tool behavior and reproduction steps; they are not proof that the student's practical was executed.

- [Jenkins Linux installation](https://www.jenkins.io/doc/book/installing/linux/)
- [Jenkins Pipeline syntax, triggers and post conditions](https://www.jenkins.io/doc/book/pipeline/syntax/)
- [GitHub repository README and relative links](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes)
- [GitHub file/folder uploads](https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository)

The original lab's seven-task organization is preserved. No requirement for Docker, a cloud provider, a website, a new merge commit or a paid service has been silently added. Instructor approval, any prescribed template, and interpretation of the deployment target must be checked separately.
