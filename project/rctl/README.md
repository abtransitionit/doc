# Project: rctl (Control CLI)

## 1. Project Lifecycle Framework

This project follows an 8-Stage Software Lifecycle. For current active phase status and historical gate approvals, see [`LIFECYCLE.md`](./lfc.log.md).


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

## 2. Project Roadmap

Roadmaps define sequencing and scope—not calendar dates.

| ID | Milestone | Target Phase | Scope / Goal |
| :---: | :--- | :--- | :--- |
| **M01** | Core Concept & PoC | Validation | Validate CLI parsing and local host execution model. |
| **M02** | SSH Execution & Inventory | Implementation | Support SSH transport and target host inventory files. |
| **M03** | First Usable Release | Release | Package `v1.0.0` static binary with core command set. |
| **M04** | Knowledge Promotion | Operation | Promote system manuals to `tool/rctl/` hub. |

---


## 3. Quick Links & Workspace Access

* **Lifecycle Log & Status:** [`lifecycle.log.md`](./lifecycle.log.md)
* **Task Backlog:** [`backlog.md`](./backlog.md)
* **Specifications Folder:** [`specs/`](./specs/)


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





