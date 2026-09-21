[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Roadmap][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[lfc whatis]: ../../../concept/lifecycle/whatis/ep.md
[tool whatis]:  ../../../concept/tool/ep.md
[prj whatis]:  ../../../concept/project/whatis/ep.md
[tool whatis]: ../kind/project/whatis/ep.md
[rm project]: ../kind/project/whatis/ep.md
[rm software]: ../kind/software/whatis/ep.md
[rm list]:     ../list/ep.md
[lfc prj whatis]:      ../../../concept/lifecycle/kind/project/whatis/ep.md
[lfc software whatis]: ../../../concept/lifecycle/kind/software/whatis/ep.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a roadmap][home topic]               | Internal | Parent |
| [What is a project roadmap][rm project]        | Internal | Kind |
| [What is a software roadmap][rm software]      | Internal | Kind |
| [List of Roadmaps][rm list]      | Internal | Kind |

<h1 align="center">How-to for Roadmap</h1>

# Build a Roadmap

It consist of defining the constarints to apply to lifecycle's phases.

## Prerequisites

Before you start, you need:

| Input | Description |
| ----- | ----------- |
| A **subject** | define the subject for which you want to build a roadmap [project][prj whatis], [software][tool whatis], ... 
| A **lifecycle** for the subject| [project lifecycle][lfc prj whatis], [software lifecycle][lfc software whatis], ... see [lifecycle][lfc whatis]|
| **Constraints** on the lifecycle's phases | Generic or specific constraints |

specific to the subject (milestones, deliverables, releases, versions, …) 

## Steps

### 1. Choose the lifecycle

- Pick the lifecycle model for the subject: waterfall, iterative, agile, hybrid.
- The lifecycle gives you the **phases**.
- The roadmap will constrain those phases.

### 2. List the phases

- Write down the phases in order.
- Example: *Initiation → Execution → Closure*.

### 3. Choose which constraints to apply

Pick some or all of the generic constraints:

| Constraint | Use it when |
| ---------- | ----------- |
| **Milestone** | You want named checkpoints |
| **Deliverable** | You want to say what is produced at each checkpoint |
| **Dependency** | Order matters between phases |
| **Priority** | You must decide what matters most |
| **Deadline** | Dates are fixed |
| **Time** | You want to express duration or horizon |

> Each kind of roadmap may rename or add properties to these constraints.
> See [project roadmap][rm project] and [software roadmap][rm software].

### 4. Assign the constraints to phases

- For each phase, attach the chosen constraints.
- Each **milestone** gets a **deliverable**.

### 5. Name the milestones

- Give each milestone a clear name.
- Optionally group milestones under a horizon.

### 6. Choose a representation

| Representation | Best for |
| -------------- | -------- |
| **Table** | Precise planning, per-phase detail |
| **Tree** | Communicating the sequence at a glance |
| **Timeline** | Emphasizing cadence and deadlines |

### 7. Review and adjust

- Verify each milestone has a clear deliverable.
- Verify the sequence matches the lifecycle.
- Adjust as the subject evolves — a roadmap is a living representation.

## example

## A generic project with a waterfall lifecycle:

**Step 1 — lifecycle:** waterfall (Initiation → Execution → Closure)

**Step 2 — phases:** Initiation, Execution, Closure

**Step 3 — constraints chosen:** Milestone, Deliverable, Time

**Step 4–5 — assignments:**

| # | Phase |  Milestone |Deliverable | Duration |
| - | ----- | ----------- | --------- | -------- |
| 1 | Initiation | Kickoff | Charter | Kickoff | 1 week |
| 2 | Execution | Beta| Working product  | 8 weeks |
| 3 | Closure | Go-live | Handover  | 2 weeks |

**Step 6 — representation:** tree view

```
Project
   │
   └── Roadmap
        ├── Milestone 01 — Kickoff (charter)
        ├── Milestone 02 — Beta (working product)
        └── Milestone 03 — Go-live (handover)
```

## Common pitfalls

| Pitfall | Fix |
| ------- | --- |
| Confusing milestone and deliverable | A milestone *marks* progress; a deliverable *is* what is produced |
| Skipping the lifecycle | A roadmap without a lifecycle has nothing to constrain |
| Making it a schedule | Keep it high-level; dates belong to the schedule |
| Over-specifying | Details go in the plan, not the roadmap |



## 4. Update — `roadmap/kind/software/whatis/ep.md`

Same change:

```
[How to build a roadmap](../../../howto/ep.md)
```

