[//]: #(home)
[home doc]:    /README.md
[home domain]:    ../../../../README.md
[home topic]: ../../../whatis/ep.md

[↖ Roadmap][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[project software whatis]: /concept/project/kind/software/whatis/ep.md
[lfc software]: /concept/lifecycle/kind/software/whatis/ep.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a roadmap][home topic]               | Internal | class |
| [What is a software project][project software whatis]     | Internal | Applied to |
| [What is a software lifecycle][lfc software]   | Internal | Related |
| [How to build a software roadmap](../howto/ep.md) | Internal | See |

<h1 align="center">What is a Software Roadmap</h1>

The concept of software roadmap

# Definition

## Software roadmap
- A [rm][home topic] applied to a [software project][project software whatis].
- That is with software Project-specific constarints





## Software-specific constraints
- The generic constraints are the same.
- Each constraint can have **properties**.

| Constraint | Properties |
| ---------- | ---------- |
| **Milestone** | Releases — v0.1, v1.0, public launch |
| **Deliverable** | Features, modules, artifacts shipped |
| **Dependency** | Order between features and components |
| **Priority** | What ships now vs later (backlog order) |
| **Deadline** | Release dates, sprint ends |
| **Time** | Iteration length, release cadence |

> In software, a **milestone** is named a **release**.

# Software-specific vocabulary

| Term | Meaning |
| ---- | ------- |
| **Release** | A **milestone** where software is delivered |
| **Feature** | A unit of functionality implemented in the software |
| **Version** | An identifier for a **release** |
| **Increment** | A step of functionality added |
| **Iteration** | A time-boxed development cycle |
| **Environment** | Where software runs — dev, staging, prod |





# Example


- **Phases** are software lifecycle stages.
- The **constraint** is Release.
- **Version** and **Feature** are properties of a release.

| # | Phase | Release (milestone) | Version | Feature |
| - | ----- | ------------------- | ------- | ------- |
| 1 | Development | First prototype | v0.1 | Core module |
| 2 | Testing | Stabilization | v0.9 | Bug fixes |
| 3 | Release | Public launch | v1.0 | Public launch |


**Software roadmap — tree view**

- **Phases** are software lifecycle stages.
- The **constraint** is Release (with version and feature as properties).

```
Software
   │
   └── Roadmap
        ├── t01 → v0.1 — Core concepts
        ├── t02 → v0.2 — Local filesystem provider
        ├── t03 → v0.3 — Remote host provider
        ├── t04 → v0.4 — VM provisioning
        ├── t05 → v0.5 — Container provisioning
        └── t06 → v1.0 — Kubernetes
```
**Software roadmap — release list**

- **Phases** are software lifecycle stages.
- The **constraint** is Release (name and feature).

```
Software
   │
   └── Roadmap
        ├── Release → Initial product
        ├── Release → Core features
        ├── Release → User feedback improvements
        ├── Release → Advanced features
        ├── Release → Performance improvements
        └── Release → Major product release
```

