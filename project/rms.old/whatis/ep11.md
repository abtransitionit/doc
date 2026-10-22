<!-- 
Main project dashboard & lifecycle matrix) 
-->

# Project: rctl (Resource Controller)

## 1. Project Lifecycle Framework

This project adopts an 8-stage iterative software lifecycle. It serves as both an execution framework and a discovery instrument.

| # | Phase | Outputs | Outcomes |
| :---: | :--- | :--- | :--- |
| **1** | **Vision** | `RFC-xxx-vision.md` | Problem statement bounded; long-term and initial goals defined. |
| **2** | **Requirements** | Requirements Matrix (`R01`+) | Functional capabilities and success criteria specified. |
| **3** | **Domain** | Domain Models, Glossary | Problem-space entities, rules, and relationships modeled. |
| **4** | **Architecture** | `SPEC-xxx.md`, ADRs | System boundaries, delegation rules, and schemas frozen. |
| **5** | **Implementation** | Production Code PRs | Feature logic and interfaces fully implemented. |
| **6** | **Validation** | Test Suites, Test Logs | Unit/integration tests pass; system execution verified. |
| **7** | **Release** | Tagged Artifacts, Changelog | Usable binaries versioned, tagged, and distributed. |
| **8** | **Operation** | Diátaxis Manuals (`tool/`) | Manuals promoted to `tool/`; project workspace archived. |

---

## 2. Project Roadmap & Scope

Roadmaps define sequencing and scope—not calendar dates.

| ID | Milestone | Target Phase | Goal / Scope |
| :---: | :--- | :--- | :--- |
| **M01** | Core Concept & PoC | Validation | Validate core model with a minimal PoC spike. |
| **M02** | Minimal Implementation | Implementation | Build core domain handlers and execution pipeline. |
| **M03** | Initial Release | Release | Deliver the first usable version to target hosts. |
| **M04** | Knowledge Promotion | Operation | Publish operational guides to `tool/` and archive specs. |

---


## Active Workspace State

* **Current Phase:** Phase 3: Domain
* **Current Milestone:** M01 (Core Concept & PoC)
* **Active Artifacts:**
  * [`specs/DOM-01-domain-model.md`](./specs/DOM-01-domain-model.md)
* **Task Tracker:** [`backlog.md`](./backlog.md)

---

## Workspace State History

| Phase | Output Artifact | Completion Date | Status |
| :---: | :--- | :---: | :---: |
| **1. Vision** | [`specs/RFC-01-vision.md`](./specs/RFC-01-vision.md) | 2026-09-15 | Approved |
| **2. Requirements** | [`specs/REQ-01-requirements.md`](./specs/REQ-01-requirements.md) | 2026-09-17 | Approved |

---
---
---
---
---

## 3. Active Workspace State

* **Current Phase:** Phase 1: Vision
* **Current Milestone:** M01 (Core Concept & PoC)
* **Active Artifacts:** [`specs/RFC-01-vision.md`](./specs/RFC-01-vision.md)
* **Task Tracker:** [`backlog.md`](./backlog.md)


## 3. Active Workspace State

* **Current Phase:** Phase 2: Requirements
* **Current Milestone:** M01 (Core Concept & PoC)
* **Active Artifacts:**
  * [`specs/RFC-01-vision.md`](./specs/RFC-01-vision.md)
  * [`specs/REQ-01-requirements.md`](./specs/REQ-01-requirements.md)
* **Task Tracker:** [`backlog.md`](./backlog.md)

## 4. System Dependencies & References

* **Domain Concepts:** [`concept/machine/whatis/ep.md`](../../concept/machine/whatis/ep.md)
* **Language Guidelines:** [`language/go/whatis/ep.md`](../../language/go/whatis/ep.md)






Yes, absolutely. Separating **Evergreen / Governance** content from **Ephemeral / State Tracking** content is essential to keep the `README.md` structured logically.

A project `README.md` should be divided into two distinct logical zones:

1. **Governance & Reference (Evergreen):** The static rules, chosen lifecycle framework, purpose, and roadmap sequence ($M01, M02, \dots$). This section changes very rarely.
2. **Execution Dashboard (Ephemeral):** The dynamic state—what phase you are in *right now*, what artifact is actively being worked on, and the completed phase history.

---

### Structure for `project/rctl/README.md`

```markdown
# Project: rctl (Control CLI)

<!-- ===================================================================== -->
<!-- ZONE 1: GOVERNANCE & REFERENCE (Evergreen)                           -->
<!-- ===================================================================== -->

## 1. Project Purpose & Scope
Build a unified control CLI system (`rctl`) to manage infrastructure, hosts, and operational workloads across local and remote environments.

## 2. Lifecycle Framework
This project follows the standard **8-Phase Software Lifecycle**:



[ 1. Vision ] ➔ [ 2. Requirements ] ➔ [ 3. Domain ] ➔ [ 4. Architecture ] ➔ [ 5. Implementation ] ➔ [ 6. Validation ] ➔ [ 7. Release ] ➔ [ 8. Operation ]

```

## 3. Roadmap & Milestones
Roadmaps define sequencing and scope (not calendar dates).

| ID | Milestone | Target Phase | Goal / Scope |
| :---: | :--- | :--- | :--- |
| **M01** | Core Concept & PoC | Validation | Validate core control model with a minimal PoC spike. |
| **M02** | Minimal Implementation | Implementation | Build core domain handlers and execution pipeline. |
| **M03** | Initial Release | Release | Deliver the first usable version to target hosts. |

---

<!-- ===================================================================== -->
<!-- ZONE 2: EXECUTION DASHBOARD (Ephemeral)                              -->
<!-- ===================================================================== -->

## 4. Active Workspace State

* **Current Phase:** Phase 3: Domain
* **Current Milestone:** M01 (Core Concept & PoC)
* **Active Artifact:** [`specs/DOM-01-domain-model.md`](./specs/DOM-01-domain-model.md)
* **Task Tracker:** [`backlog.md`](./backlog.md)

## 5. Workspace State History

| Phase | Output Artifact | Completion Date | Status |
| :---: | :--- | :---: | :---: |
| **1. Vision** | [`specs/RFC-01-vision.md`](./specs/RFC-01-vision.md) | 2026-09-15 | Approved |
| **2. Requirements** | [`specs/REQ-01-requirements.md`](./specs/REQ-01-requirements.md) | 2026-09-17 | Approved |

---

## 6. System Dependencies & References

* **Domain Concepts:** [`concept/machine/whatis/ep.md`](../../concept/machine/whatis/ep.md)
* **Language Guidelines:** [`language/go/whatis/ep.md`](../../language/go/whatis/ep.md)


---

### Why this separation works

* **Prevents Merge Conflicts & Confusion:** Anyone reading the top half understands the project's permanent rules and scope. Anyone reading the bottom half sees the live work stream.
* **Clear Promotion Path:** When Phase 8 (Operation) is completed, the ephemeral specs in `specs/` are archived, promoted to `/tool/rctl/`, and the execution dashboard resets for the next feature cycle or milestone.