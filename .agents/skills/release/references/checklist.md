# Release checklist

- Confirm requested version/destination against DESCRIPTION; do not assume CRAN,
  Bioconductor or GitHub Releases.
- Prepare release contents on a feature branch and PR.
- Verify changelog entries and PR links; preserve Unreleased.
- Establish reproducible upstream dependency packaging: revision, headers,
  compiled components and licenses. A sibling checkout is a development setup.
- Run scripts/test.sh against the selected upstream checkout.
- Run scripts/release-check.sh and inspect errors, warnings and notes in the
  full R CMD check report; exit status alone does not establish readiness.
- Inspect archive contents for native binaries, local settings and unrelated files.
- Verify intended R versions/platforms; a local macOS run does not prove portability.
- Verify archive installation in a clean environment without an undeclared
  sibling directory. Passing GENOGROVE_DIR does not prove standalone installation.
- Confirm API documentation and native pointer serialization limitations.
- Obtain authorization for the specific tag/upload/publication before performing it.
