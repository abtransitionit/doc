[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(doc)

[←][home]

<h1 align="center">Metadoc specification</h1>

# REQ-01: Functional & Technical Requirements

## 1. Functional Requirements

| Requirement ID | Module | Description | Priority |
|---|---|---|---|
| REQ-F-001 | Scaffolder | Instantiate the generic sub-hub directory layout (`concept/`, `language/`, `tool/`, `project/`) with standardized `whatis/ep.md` entry points | High |
| REQ-F-002 | Link Indexer | Traverse and index nested sub-hub entry paths (`<hub>/<namespace>/whatis/ep.md`) into a central graph | High |
| REQ-F-003 | AST Validator | Verify cross-hub relative links across distinct taxonomy namespaces and fail on dead links | High |
| REQ-F-004 | Search Engine | Query metadata across both foundational hubs (`concept`, `language`, `tool`) and ephemeral hubs (`project`) | Medium |
| REQ-F-005 | Federation Engine | Resolve and link entry points (`ep.md`) across external remote metadoc instances | Low |

## 2. Non-Functional Requirements

| Requirement ID | Category | Target Metric / Constraint | Priority |
|---|---|---|---|
| REQ-NF-001 | Performance | Parse and build link graph for 5,000 Markdown files across all hubs in under 1 second | High |
| REQ-NF-002 | Determinism | Enforce strict zero-HTML Markdown table formatting and predictable path resolution | High |
| REQ-NF-003 | Zero-Dependency | Single static binary execution across Linux, macOS, and Windows environments | High |

## 3. Requirement Traceability

| Requirement | Specification Target | Verification Artifact |
|---|---|---|
| REQ-F-001 | `doc/project/metadoc/spec/spec-01-architecture.md` | Scaffolder Integration Unit Tests |
| REQ-F-002 | `doc/project/metadoc/spec/dom-01-domain-model.md` | AST Graph Traversal Tests |
| REQ-F-003 | `doc/project/metadoc/spec/dom-01-domain-model.md` | CI Validation Engine Tests |


