[//]: #(home)
[home]: ./README.md

[//]: #(doc)

[←][home]

<h1 align="center">Rctl ADR 02: Decoupled Output Formatting</h1>


* **Status:** Accepted
* **Date:** 2026-09-17
* **Deciders:** Core Engineering Team
* **Relates To:** [`REQ-08`](../spec/REQ-01-requirements.md), [`SPEC-01-architecture.md`](../spec/SPEC-01-architecture.md)

---

## Context & Problem Statement

`rctl` requires output capabilities for both human operators inspecting terminal output and automated scripts consuming structured data. We need to decide how presentation formatting (e.g., plain text, human-readable tables, JSON) is structured relative to command execution and transport abstractions.

---

## Decision Drivers

* **R08 (Flexible Output):** Native support for both terminal-friendly formatted text and machine-readable JSON via flags (e.g., `--json`).
* **Single Responsibility Principle:** Transport components (`pkg/transport`) should manage execution streams without knowledge of CLI flags or rendering logic.
* **Testability:** Output formatters must be unit-testable without requiring active transport connections or remote host execution.

---

## Considered Options

1. **Option 1:** In-band formatting where transport modules format execution outputs directly.
2. **Option 2:** Standardized execution result streams paired with isolated presentation-layer formatters.

---

## Decision Outcome

**Chosen Option:** Option 2 (Decoupled Presentation Layer).

### Positive Consequences

* **Clean Module Boundaries:** Transports return raw `Result` models containing standard streams (`io.Reader`), keeping transport packages free of presentation logic.
* **Extensibility:** Adding new output formats (e.g., YAML, CSV) requires adding a formatter in `pkg/cli/format` without modifying transport code.
* **Pipe Compatibility:** Raw streams can be piped directly to stdout/stderr or passed to formatters, avoiding unnecessary memory buffering for large outputs.

### Negative Consequences

* Requires defining explicit formatter interfaces and result model contracts across package boundaries.

---

## Option Comparison

| Metric / Requirement | In-Band Formatting (Option 1) | Decoupled Formatters (Option 2) |
| :--- | :--- | :--- |
| **Transport Coupling** | High (Transports need formatting flags) | None (Transports return raw streams) |
| **Adding New Formats** | Modifies transport packages | Touches only `pkg/cli/format` |
| **Unit Testing** | Requires mocking transports to test output | Test formatters with mock `io.Reader` |
| **Stream Performance** | High risk of memory buffering | Direct I/O streaming support |