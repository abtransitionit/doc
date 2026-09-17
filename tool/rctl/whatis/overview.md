[//]: #(home)
[home]: ../../README.md

[//]: #(doc)

[↖][home]

Related topics

| Topic                                            | Location | Kind    |
| ------------------------------------------------ | -------- | ------- |

**Document's status**
- Early stage.
- The project is currently being defined (concepts, architecture, ...)

<h1 align="center">What is rctl</h1>


# What is rctl?

`rctl` (Remote Control Engine) is a lightweight, agentless CLI execution engine designed for ad-hoc remote operations and environment inspection across heterogeneous infrastructure.

---

## Core Principles

* **Agentless:** Operates via standard SSH transport without requiring remote software daemons.
* **Statutory Local Bounds:** Enforces strict non-root local process isolation when executing commands on localhost.
* **Structured & Human Outputs:** Supports both tabular text formatting and deterministic JSON stream outputs for CI/CD integration.