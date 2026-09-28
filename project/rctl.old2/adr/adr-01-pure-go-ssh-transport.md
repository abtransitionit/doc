[//]: #(home)
[home]: ./README.md

[//]: #(doc)

[←][home]

<h1 align="center">Rctl ADR 01: Pure Go SSH Transport</h1>


* **Status:** Accepted
* **Date:** 2026-09-17
* **Deciders:** Core Engineering Team
* **Relates To:** [`REQ-03`](../REQ-01-requirements.md), [`SPEC-01-architecture.md`](../SPEC-01-architecture.md)

---

## Context & Problem Statement

`rctl` requires remote execution capability on target hosts over SSH. We need to decide whether to invoke the host system's native `ssh` binary via subprocesses or use a native Go library integration.

---

## Considered Options

1. **Option 1:** Subprocess execution of system `ssh` binary.
2. **Option 2:** Native Go SSH client library (`golang.org/x/crypto/ssh`).

---

## Decision Outcome

**Chosen Option:** Option 2 (`golang.org/x/crypto/ssh`).

### Positive Consequences
* Ensures `rctl` remains a single, fully self-contained binary without external runtime dependencies (aligns with `C01`).
* Provides granular, programmatic control over SSH sessions, stream handling, and authentication flows.
* Guarantees identical execution behavior across Linux, macOS, and Windows.

### Negative Consequences
* Requires managing SSH agent interfaces and key parsing directly within Go code.