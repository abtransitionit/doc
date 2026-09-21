[//]: #(home)
[home domain]:    ../../../../README.md
[home doc]:    /README.md
[home topic]: ../whatis/ep.md

[↖ Roadmap][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[project whatis]: /concept/project/whatis/ep.md
[lfc whatis]:     /concept/lifecycle/whatis/ep.md
[rm project]:     ../whatis/ep.md
[rm howto]:       ../../../howto/ep.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a project roadmap][rm project]        | Internal | Parent |
| [What is a lifecycle][lfc whatis]              | Internal | Related |
| [What is a project][project whatis]            | Internal | Applied to |

<h1 align="center">How-to for Project Roadmap</h1>

# Build a project roadmap

It consist of defining the constarins to apply to a lifecycle.

## Prerequisites

Before you start, you need:

| Input | Where it comes from |
| ----- | ------------------- |
| A [project][project whatis] | Defined goal, scope, stakeholders |
| A [lifecycle][lfc whatis] | The stages the project goes through |
| A list of deliverables or goals | Charter, requirements, or vision |

## Steps

### 1. Choose the lifecycle

- Pick the [lifecycle][lfc whatis] model: waterfall, iterative, agile, hybrid.
- The lifecycle gives you the **phases**.
- The roadmap will constrain those phases.

### 2. List the phases

- Write down the phases in order.
- Example: *Initiation → Execution → Closure*.

### 3. Choose which constraints to apply

Pick some or all of the generic constraints:

| Constraint | Use it when |
| ---------- | ----------- |
| **Milestone** | You want named checkpoints (kickoff, beta, go-live) |
| **Deliverable** | You want to say what is produced at each checkpoint |
| **Dependency** | Order matters between phases |
| **Priority** | You must decide what is in scope vs out of scope |
| **Deadline** | Dates are fixed |
| **Time** | You want to express duration or horizon |

### 4. Assign the constraints to phases

- For each phase, attach the chosen constraints.
- Each **milestone** gets a **deliverable**.

### 5. Name the milestones

- Give each milestone a clear name: `Kickoff`, `Beta`, `Go-live`.
- Optionally group milestones under a horizon.

### 6. Choose a representation

| Representation | Best for |
| -------------- | -------- |
| **Table** | Precise planning, per-phase detail |
| **Tree** | Communicating the sequence at a glance |
| **Timeline** | Emphasizing deadlines and horizon |

### 7. Review and adjust

- Verify each milestone has a clear deliverable.
- Verify the sequence matches the lifecycle.
- Adjust as the project evolves — a roadmap is a living representation.

## Worked example

A project with a waterfall lifecycle:

**Step 1 — lifecycle:** waterfall (Initiation → Execution → Closure)

**Step 2 — phases:** Initiation, Execution, Closure

**Step 3 — constraints chosen:** Milestone, Deliverable, Time

**Step 4–5 — assignments:**

| # | Phase | Deliverable | Milestone | Duration |
| - | ----- | ----------- | --------- | -------- |
| 1 | Initiation | Charter | Kickoff | 1 week |
| 2 | Execution | Working product | Beta | 8 weeks |
| 3 | Closure | Handover | Go-live | 2 weeks |

**Step 6 — representation:** tree view
