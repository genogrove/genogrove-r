---
name: release
description: Prepare or check an R release for version, changelog, dependency packaging and validation readiness.
---

Read [the release checklist](references/checklist.md), DESCRIPTION, changelog,
upstream selection and build scripts. Separate preparation from publication.
`scripts/release-check.sh` checks a source package; it never publishes.
Prepare changes on a feature branch for a release PR. Report concrete blockers,
especially dependency packaging and untested platforms. Do not infer the version
or publishing destination. Tags, uploads, merges and publishing require user
authorization. Complete independent checks before asking for missing inputs.
