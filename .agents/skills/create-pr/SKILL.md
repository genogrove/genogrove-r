---
name: create-pr
description: Commit and open a PR for requested R changes using project classification and QC conventions.
---

Read status, staged/unstaged diffs, branch, recent commits and AGENTS.md.
Use [PR conventions](references/conventions.md). Create a feature branch before
editing main. Include issue numbers only when verified in this repository.
Stage specific relevant files, excluding secrets, native artifacts and unintended
upstream changes. Do not invent co-author identities. Changelog entries can wait
until review knows the PR number. Record concrete checks and limitations.

Commit/push authorized changes; update an existing branch PR instead of duplicating
it. Inspect repository labels and apply one classification matching the diff;
create a missing label only within an authorized PR workflow. Write the exact
body to a temporary file and run:
`gh pr create --base main --head <branch> --title <title> --label <label> --body-file <file>`.
Use a title under 70 characters, concrete summary and verifiable QC items.
Leave human QC unchecked. Report URL and label. Do not merge.
