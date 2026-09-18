[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Metadoc specification</h1>

# Step 02: Initial Requirements

This document defines the functional capabilities, structural standards, and operational constraints required for the initial release of `metadoc`. These requirements expand upon `RFC-01-vision.md` and remain independent of specific tools, parsers, or implementation details.

---

## 1. Functional Requirements

| ID | Requirement | Priority | Target Phase / Milestone |
| --- | --- | --- | --- |
| **R01** | Define a standardized directory layout for organizing knowledge hubs across repositories. | High | Phase 1 / M01 |
| **R02** | Support custom sub-hub taxonomy declarations within the Master Entry Point (`README.md`). | High | Phase 1 / M01 |
| **R03** | Enforce standardized entry points (`whatis/ep.md`) across sub-hub namespaces. | High | Phase 1 / M01 |
| **R04** | Establish cross-referencing conventions for linking documents across sub-hubs. | Medium | Phase 1 / M02 |
| **R05** | Support multi-hub federation standards to interlink separate, domain-specific repositories. | Medium | Phase 2 / M01 |

---

## 2. Interface Requirements

| ID | Requirement | Priority | Target Phase / Milestone |
| --- | --- | --- | --- |
| **R06** | Require clean, standardized Markdown structure for all hub entry points and taxonomies. | High | Phase 1 / M01 |
| **R07** | Use relative path resolution rules for all internal and cross-hub document links. | High | Phase 1 / M01 |
| **R08** | Maintain explicit navigation indices within every sub-hub `README.md` and `ep.md`. | Medium | Phase 1 / M02 |

---

## 3. Operational & System Constraints

| ID | Constraint | Rationale |
| --- | --- | --- |
| **C01** | Remain platform-agnostic and fully readable using plain Markdown viewings/renderers. | Ensures zero lock-in to proprietary documentation platforms or specific build engines. |
| **C02** | Maintain strict separation between long-term knowledge hubs (`concept`, `language`, `tool`) and ephemeral work (`project`). | Prevents historical knowledge rot and keeps daily active work isolated from foundational specifications. |

---

## 4. Requirement Verification Matrix

```text
[ R01 - R03 ] ──► Validated by: Static linting of hub file trees and entry point paths
[ R04 - R05 ] ──► Validated by: Link resolution testing across local and remote hub manifests
[ R06 - R08 ] ──► Validated by: Markdown AST structure validation and relative path checks