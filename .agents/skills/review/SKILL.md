---
name: review
description: Review R binding PRs for upstream parity, correctness, test coverage and existing feedback.
---

Identify the PR from the user or current branch. Read AGENTS.md, the PR diff,
base/head, body, labels, checks, review summaries and inline comments. Compare
native calls with the selected upstream headers, not assumptions about their names.

Check external-pointer ownership/finalizers, owner retention, R GC protection,
key invalidation, mutation of inserted keys, exception translation, NA/numeric
bounds, coordinate/strand/default parity, registration and packaging. Map changed
public behavior to assertions in tests/. Review avoidable complexity separately.
Do not flag documented unbound features or upstream design choices as defects.

Assess every existing reviewer comment on merit and the latest diff. Report
severity, file/line, consequence and fix. Keep a disposition ledger: Address,
Exclude with reason, or Discuss. Distinguish actual validation from proposed
commands; use scripts/test.sh when execution is in scope. Independent reviewer
passes are optional, require authorization and must be identified honestly.

Report in chat by default. When asked to post, reply in inline threads and post
one consolidated review via a body file. A review does not authorize fixes or
merge. Never check a human-review checkbox. If fixes are requested, revalidate
and update the ledger. Check label/summary consistency using
[PR conventions](../create-pr/references/conventions.md). When changelog upkeep
is requested, add an accurate linked Unreleased entry; preserve release history.
