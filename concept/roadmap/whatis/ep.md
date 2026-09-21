[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[cst whatis]: ../whatis/constraint.md
[rm constraint whatis]: ../whatis/constraint.md
[rm howto]: ../howto/ep.md
[lfc whatis]:     ../../../concept/lifecycle/whatis/ep.md
[project whatis]: ../../../concept/project/whatis/ep.md
[rm project whatis]:  ../../../concept/roadmap//kind/project/whatis/ep.md
[rm software whatis]: ../../../concept/roadmap//kind/software/whatis/ep.md
[rm list]: ../list/ep.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a Roadmap Constraint][rm constraint whatis]              | Internal | Member |
| [What is a lifecycle][lfc whatis]              | Internal | Related |
| [What is a project][project whatis]            | Internal | Uses |
| [What is a project roadmap](../kind/project/whatis/ep.md) | Internal | Kind |
| [What is a software roadmap](../kind/software/whatis/ep.md) | Internal | Kind |
| [How-to for Roadmaps][rm howto] | Internal | Kind |
| [List of Roadmaps][rm list] | Internal | list |

<h1 align="center">What is a Roadmap</h1>

The concept of roadmap

# Definition

## Roadmap
- Add [constraints][cst whatis] to [lifecycle][lfc whatis]'s phases
- Those constraints add indication of the progression inside the lifecycle.
- Can exist **independently** of any lifecycle (e.g. a career roadmap).
- Answers the questions: 
  - **Where are we now?** 
  - **Where are we going?** 
  - **How do we get there?**

## Constraint
- The roadmap may define one or more **constraints** to attach to the lifecycle phases.
- roadmap's constraints are domain-independent. 
- Example of contarinst that can be used:

| Constraint | Role |
| ---------- | ---- |
| **Milestone** | A key checkpoint |
| **Deliverable** | What is produced at a checkpoint |
| **Dependency** | What must come before what |
| **Priority** | What matters most |
| **Deadline** | A fixed date |
| **Time** | Duration and horizon |

# Representations

There are different possible representations.

## Graph

```yaml
# Generic view
Start --> Phase1 --> Phase2 --> Phase3 --> Target
            |          |          |
         Milestone  Milestone  Milestone
            |          |          |
         2 days      1 day     6 days
```

## Table

A roadmap with 1 constraints : milestone.

| # | Phase | Milestone |
| - | ----- | --------- |
| 1 | Phase1 | Milestone1 |
| 2 | Phase2 | Milestone2 |
| 3 | Phase3 | Milestone3 |

A roadmap with 2 constraints : milestone and time constraint reads as schedule.

| # | Phase | Duration |
| - | ----- | -------- |
| 1 | Phase1 | 2 days |
| 2 | Phase2 | 1 day |
| 3 | Phase3 | 6 days |

# Example of roadmaps

cf. [list of roadmaps][rm list]





# Todo
**Example 02**:
```

                    ┌── MVP ──────────────┐
                    │                     │
v0.1              v0.2                  v1.0
Core model    Local provisioning    Remote provisioning
                                     
                    ↓
              Kubernetes support

                    ↓
              Cloud providers
```




# Todo : Roadmap vs Plan vs Schedule

| Concept | Focus |
| ------- | ----- |
| **Roadmap** | Direction and major steps — the *what* and *why*, over a long horizon |
| **Plan** | How the work will be done — the *how* |
| **Schedule** | When each task happens — the *when*, precise dates |

A roadmap stays high-level. A plan and a schedule add detail under it.


