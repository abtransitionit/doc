[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Rctl ADR</h1>


These decisions govern the technical design. 

Each ADR Is:
  - an immutable record created during Phase:Architecture
  - enforced through Phase:Implementation and Phase:Validation.

# Index

| ADR ID | Title | Status | Primary Requirement | Local File |
| :---: | :--- | :---: | :---: | :--- |
| **ADR-01** | Pure Go SSH Transport | Accepted | `REQ-03` | [`ADR-01-pure-go-ssh-transport.md`](./ADR-01-pure-go-ssh-transport.md) |
| **ADR-02** | Decoupled Output Formatting | Accepted | `REQ-08` | [`ADR-02-decoupled-output-formatting.md`](./ADR-02-decoupled-output-formatting.md) |
| **ADR-03** | Statutory Non-Root Local Scope | Accepted | `C02` | [`ADR-03-statutory-non-root-local-scope.md`](./ADR-03-statutory-non-root-local-scope.md) |

---
---

* **ADR-01: Pure Go SSH Transport:** Use Go's standard `golang.org/x/crypto/ssh` package rather than shelling out to a system `ssh` binary. This avoids runtime dependency on local SSH binaries.
* **ADR-02: Decoupled Output Formatting:** Separate command execution from console output rendering. Executors return streams, allowing the CLI presentation layer to toggle between human-readable tables and raw JSON streams without touching transport code.
* **ADR-03: Statutory Non-Root Local Scope:** Local transport commands run strictly within the privilege context of the user invoking `rctl`.

---
---

## Lifecycle Traceability & Process

This index establishes bidirectional traceability across the 8-phase software lifecycle:

```
Requirements (Phase 2) ──► Architecture (Phase 4) ──► Standalone ADR ──► Code & Tests (Phases 5 & 6)
  REQ-03 (SSH Support)       SPEC-01 Spec           ADR-01 File       pkg/transport/ssh/
  C02    (Non-Root)          SPEC-01 Spec           ADR-03 File       pkg/transport/local/
```  



* **Phase 2 (Requirements):** Defines *what* is needed (`REQ-03`).
* **Phase 4 (Architecture):** Formulates the system design (`SPEC-01`) and locks individual technical trade-offs into `adr/ADR-0x.md`.
* **Phase 5 (Implementation):** Pull Requests and Go code implementation (`src/`) must explicitly reference the governing ADR (e.g., `feat(transport): implement pure go ssh client (ADR-01)`).
* **Phase 6 (Validation):** Test cases verify that implementation strictly adheres to the boundaries set in the ADRs.