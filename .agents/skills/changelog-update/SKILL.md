---
name: changelog-update
description: Draft or update R changelog entries from verified history and PRs.
---

Read CHANGELOG.md if present and DESCRIPTION for the package version. Find the
latest release tag; if absent inspect all history. Group meaningful changes,
verify this repository's PR links, and follow existing style or Keep a Changelog.
Use Added, Changed, Fixed, Refactored and Removed, omitting empty sections.
Distinguish binding additions, fixes, packaging and actual upstream version bumps.
Do not claim a dependency pin exists for a local-checkout build.

Draft requests return text only. Update requests write on a feature branch.
Use Unreleased for ongoing changes and a dated version only for an actual release.
Do not infer a release date from commit dates. Neither drafting nor updating
creates a tag, release or publication.
