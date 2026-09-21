[//]: #(home)
[home domain]:    ../../../../README.md
[home doc]:    /README.md
[home topic]: ../../../whatis/ep.md

[↖ Roadmap][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[rm prj howto]:   ../howto/ep.md
[rm howto]:       ../../../howto/ep.md
[project whatis]: /concept/project/whatis/ep.md
[lfc whatis]:     /concept/lifecycle/whatis/ep.md


Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a roadmap][home topic]               | Internal | class |
| [What is a lifecycle][lfc whatis]              | Internal | Related |
| [What is a project][project whatis]            | Internal | Applied to |
| [How-to for roadmap][rm howto] | Internal | See |
| [How-to for project roadmap][rm prj howto] | Internal | See |

<h1 align="center">What is a Project Roadmap</h1>

The concept of project roadmap

# Definition

- A [rm][home topic] applied to a [project][project whatis].
- It disctiguih from other roadmap by
  - the lifecycle used
  - the Project-specific constraints

# Project-specific constraints

The generic constraints are the same. Here is how they manifest in a project:

| Constraint | In a project |
| ---------- | ------------ |
| **Milestone** | Phase gates — kickoff, beta, go-live |
| **Deliverable** | Project artifacts — charter, working product, handover |
| **Dependency** | Order between project phases and tasks |
| **Priority** | What is in scope vs out of scope |
| **Deadline** | Fixed project dates |
| **Time** | Project duration and horizon |

# Example

**Project roadmap 01**

- **Phases** are project lifecycle stages.
- **constraints** are deliverables and milestones

| # | Phase | Deliverable | Milestone |
| - | ----- | ----------- | --------- |
| 1 | Initiation | Charter | Kickoff |
| 2 | Execution | Working product | Beta |
| 3 | Closure | Handover | Go-live |


**Project roadmap 02**

- **Phases** are project lifecycle stages.
- **constraints** are deliverables and milestones

```
Project
   │
   └── Roadmap
        ├── Milestone 01 — Validate the core concept
        ├── Milestone 02 → Define the domain model
        ├── Milestone 03 → Build the first prototype v0.1 (core model)
        ├── Milestone 04 → Support local resources
        ├── Milestone 05 → Support remote hosts
        ├── Milestone 06 → First usable release
        └── Milestone 07 → Kubernetes support
```
