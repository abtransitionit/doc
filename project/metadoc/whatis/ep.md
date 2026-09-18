[//]: #(home)
[home set]: ../../README.md
[home doc]:     ../../../README.md

[↖ Project][home set] · [↖ Doc][home doc]

[//]: #(doc)
[project whatis]: ../../../concept/project/whatis/ep.md
[project software lfc whatis]: #
[phase log status whatis]: ../log/phase.log.md


<h1 align="center">Project: Metadoc</h1>

A Documentation Hub



# The Lifecycle

- This [project][project whatis] follows the [Software Project Lifecycle][project software lfc whatis]. 
- See the [phase log][phase log status whatis] for the current active phases status and historical gate approvals.


| # | Phase | Outputs | Outcomes |
| :---: | :--- | :--- | :--- |
| **1** | **Vision** | `RFC-xxx-vision.md` | Problem statement bounded; goals defined. |
| **2** | **Requirements** | `REQ-xxx-requirements.md` | Functional needs and capabilities specified. |
| **3** | **Domain** | `DOM-xxx-domain-model.md` | Problem-space entities, rules, and relationships modeled. |
| **4** | **Architecture** | `SPEC-xxx-architecture.md` | System boundaries, schemas, and ADRs frozen. |
| **5** | **Implementation** | Go Code PRs | Feature logic fully implemented in repository code. |
| **6** | **Validation** | Test Suites | Integration/unit tests pass; help text verified. |
| **7** | **Release** | Tagged Binary, Changelog | Binaries versioned (`v1.0.0`) and distributed. |
| **8** | **Operation** | Diátaxis Manuals (`tool/rctl/`) | Manuals promoted to `/tool/rctl/`; specs archived. |

---

# The Roadmap

This initial roadmap define sequencing and scope—not calendar dates.

| ID | Milestone | Target Phase | Scope / Goal |
| :---: | :--- | :--- | :--- |
| **M01** | Core Concept & PoC | Validation | Validate CLI parsing and local host execution model. |
| **M02** | SSH Execution & Inventory | Implementation | Support SSH transport and target host inventory files. |
| **M03** | First Usable Release | Release | Package `v1.0.0` static binary with core command set. |
| **M04** | Knowledge Promotion | Operation | Promote system manuals to `tool/rctl/` hub. |

---

# Documents Index

| Document | Category | Target Audience | Owner | Link |
| :--- | :--- | :--- | :--- | :--- |
| **Project Charter & Vision** | Strategy | All Hands / Stakeholders | Product Lead | [`RFC-01`](../spec/RFC-01-vision.md) |
| **System Architecture Spec** | Technical | Engineering / Security | Lead Architect | [`SPEC-01`](../spec/SPEC-01-architecture.md) |
| **Domain Model & Entities** | Technical | Engineering | Tech Lead | [`DOM-01`](../spec/DOM-01-domain-model.md) |
| **System Requirements** | Product | Product / QA | Product Manager | [`REQ-01`](../spec/REQ-01-requirements.md) |
| **ADR Governance Index** | Governance | Engineering | Lead Architect | [`ADR Index`](../adr/README.md) |
| **Master Task Backlog** | Execution | Engineering | Project Manager | [`Backlog`](../log/backlog.md) |
| **Active Lifecycle Status** | Execution | Engineering / Leadership | DevOps Lead | [`Lifecycle Log`](../log/lifecycle.log.md) |
| **Task Scratchpads Directory** | Operations | Engineering | Dev Team | [`tasks/`](../log/task/) |


**Category**
- **Strategic**: Vision, Business Case, Roadmap
- **Technical**: Architecture, Security, API Docs
- **Operational**: Onboarding Guide, Release Checklist, Runbooks

## Lifecycle Cross-Reference Link Matrix

This matrix governs bidirectional traceability across all artifacts, ensuring strict alignment between requirements, design decisions, execution tasks, and implementation code:

| Workspace Layer | Artifact File | Dependencies (Links Out To) | Referenced By (Linked In From) |
| --- | --- | --- | --- |
| **Evergreen Hub** | [`whatis/ep.md`](https://www.google.com/search?q=./ep.md) | `RFC-01`, `lifecycle.log` | Repository Root / Onboarding |
| **Lifecycle Status** | [`log/lifecycle.log.md`](https://www.google.com/search?q=../log/lifecycle.log.md) | `spec/*`, `adr/README.md`, `backlog.md` | `whatis/ep.md` |
| **Task Backlog** | [`log/backlog.md`](https://www.google.com/search?q=../log/backlog.md) | `spec/*`, `adr/*`, `tasks/*` | `lifecycle.log.md` |
| **Requirements** | [`spec/REQ-01-requirements.md`](https://www.google.com/search?q=../spec/REQ-01-requirements.md) | [`spec/RFC-01-vision.md`](https://www.google.com/search?q=../spec/RFC-01-vision.md) | `SPEC-01`, `ADR-*`, `TASK-*` |
| **Domain Model** | [`spec/DOM-01-domain-model.md`](https://www.google.com/search?q=../spec/DOM-01-domain-model.md) | [`spec/REQ-01-requirements.md`](https://www.google.com/search?q=../spec/REQ-01-requirements.md) | `SPEC-01`, `TASK-02` |
| **Architecture** | [`spec/SPEC-01-architecture.md`](https://www.google.com/search?q=../spec/SPEC-01-architecture.md) | `REQ-01`, `DOM-01`, `adr/README.md` | `lifecycle.log.md`, `backlog.md`, `TASK-*` |
| **ADR Governance** | [`adr/README.md`](https://www.google.com/search?q=../adr/README.md) | `REQ-01`, `SPEC-01`, `ADR-*` | `SPEC-01`, `lifecycle.log.md` |
|  | [`adr/ADR-01-pure-go-ssh-transport.md`](https://www.google.com/search?q=../adr/ADR-01-pure-go-ssh-transport.md) | `REQ-03` | `adr/README.md`, `TASK-02`, `TASK-03` |
|  | [`adr/ADR-02-decoupled-output-formatting.md`](https://www.google.com/search?q=../adr/ADR-02-decoupled-output-formatting.md) | `REQ-08` | `adr/README.md`, `TASK-01`, `TASK-03` |
|  | [`adr/ADR-03-statutory-non-root-local-scope.md`](https://www.google.com/search?q=../adr/ADR-03-statutory-non-root-local-scope.md) | `C02` | `adr/README.md`, `TASK-02` |
| **Task Execution** | [`log/tasks/TASK-01-cli-taxonomy.md`](https://www.google.com/search?q=../log/tasks/TASK-01-cli-taxonomy.md) | `REQ-01`, `SPEC-01`, `ADR-02` | [`log/backlog.md`](https://www.google.com/search?q=../log/backlog.md) |
|  | [`log/tasks/TASK-02-config-schema.md`](https://www.google.com/search?q=../log/tasks/TASK-02-config-schema.md) | `DOM-01`, `SPEC-01`, `ADR-01`, `ADR-03` | [`log/backlog.md`](https://www.google.com/search?q=../log/backlog.md) |
|  | [`log/tasks/TASK-03-init-go-module.md`](https://www.google.com/search?q=../log/tasks/TASK-03-init-go-module.md) | `SPEC-01`, `ADR-01`, `ADR-02` | [`log/backlog.md`](https://www.google.com/search?q=../log/backlog.md) |


---

## 4. System Dependencies & References

* **Domain Concepts:** [`concept/machine/whatis/ep.md`](../../concept/machine/whatis/ep.md)
* **Language Patterns:** [`language/go/whatis/ep.md`](../../language/go/whatis/ep.md)

---
---
---
---
---
---
