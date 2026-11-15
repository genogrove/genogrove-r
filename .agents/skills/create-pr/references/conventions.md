# PR conventions

Adapted from pygenogrove's create-pr command for R.

| Label | Prefix | Summary section |
|---|---|---|
| feature | feat/ | Added |
| enhancement | enhance/ | Changed |
| bug | fix/ | Fixed |
| hotfix | hotfix/ | Fixed |
| refactor | refactor/ | Refactored |
| chore | chore/ | Changed |
| docs | docs/ | Changed |
| test | test/ | Added |
| revert | revert/ | Removed |

Example body:

```markdown
## Summary
### Added
- Observable behavior and purpose.

## QC
- [ ] I, as a human being, have checked each line of code in this pull request
- [ ] A specific build or behavioral assertion.
```

Mark automated items only with evidence. Never mark human review on the user's
behalf. Do not add generated-by signatures or false co-author trailers.
