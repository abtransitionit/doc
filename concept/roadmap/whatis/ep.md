[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md

[↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[model whatis]:   /concept/model/whatis/ep.md
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
- A [lifecycle][lfc whatis] with [constraints][rm constraint whatis].
- A lifecycle **that** is constrained.
- Adds/attachs [constraints][cst whatis] to [lifecycle][lfc whatis]'s phases
- [Model][model whatis] a [lifecycle][lfc whatis] with [constraints][rm constraint whatis]
- **Purpose**: track progression inside the lifecycle.

# Model

```yaml
Rodamop:
  - Lycycle:
    - constraint 1
    - constraint 2
    - constraint 3
```    

# Purpose
- adds indication of the **progression** inside a decided/deducted [lifecycle][lfc whatis] of an *entity* 
- provides the following **information**: 
   - the **phase** we are in inside the lifecycle of an entity 

## Constraint
constraints maybe 
- generic
- subject/entity-specific
- generic-semantic-extented (same syntax different meaning)
- generic-syntaxic-extented (same semantic different syntax)


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

inherited from [lifecycle][lfc whatis]
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




# Todo

## Lifecycle vs roadmap
- A lifecycle defines the **stages**.
- A [roadmap][rm whatis] is a lifecycle **with constraints**.
- **lifecycle = stages. roadmap = stages + constraints.**


# Idea
## Common meaning that confort my model of roadmap as alifecycle
- the term **roadmap** = a sequence of town in film .. but each stage brings its constraint
- the lifecycle = the sequence of town (dynamic/static). the constraints (what is lived in each town)