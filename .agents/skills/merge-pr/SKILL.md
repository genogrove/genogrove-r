---
name: merge-pr
description: Merge an explicitly requested R PR after verifying checks, QC, review and changelog readiness.
---

Only run for a requested merge. Identify the exact PR and inspect latest head,
base, mergeability, required checks, reviews and body. Stop for failed/pending
required checks, conflicts, blocking findings or incomplete required QC. Report
absent CI as absent, not passed. Verify an accurate linked Unreleased changelog
entry exists; if absent, report the review/changelog work still needed.

Never tick human QC yourself. Existing explicit user confirmation may satisfy it;
otherwise ask when that required item is incomplete. Do not add a human checkbox
retroactively to a PR that does not use one. If corrections add commits, recheck
the new head. Use `gh pr merge <number> --squash`, confirm merged status, then
update local main with a fast-forward-only pull. Delete only the merged feature
branch when cleanup is authorized. Never discard local changes to switch.
Report status and documentation follow-ups; do not change sibling repositories
or create external issues without authorization.
