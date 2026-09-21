[//]: #(home)
[home domain]:    ../../../../README.md
[home doc]:    /README.md
[home topic]: ../howto/ep.md

[↖ Project][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[prj software]: /concept/project/kind/software/whatis/ep.md
[lfc software]: /concept/lifecycle/kind/software/whatis/ep.md
[rm software]:  ../whatis/ep.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a software roadmap][rm software]      | Internal | Parent |
| [What is a software lifecycle][lfc software]   | Internal | Related |
| [What is a software project][prj software]     | Internal | Applied to |

<h1 align="center">Build a Software Roadmap</h1>


## Prerequisites

Before you start, you need:

| Input | Where it comes from |
| ----- | ------------------- |
| A [software project][prj software] | Defined scope, goal, stakeholders |
| A [software lifecycle][lfc software] | The stages the project goes through |
| A list of features or goals | Product backlog, requirements, or vision |

## Steps

### 1. Choose the lifecycle

- Pick the [software lifecycle][lfc software] model: waterfall, iterative, agile, hybrid.
- The lifecycle gives you the **phases**.
- The roadmap will constrain those phases.

### 2. List the phases

- Write down the phases in order.
- Example: *Development → Testing → Release*.

### 3. Choose which constraints to apply

Pick some or all of the generic constraints, in software vocabulary:

| Constraint | Use it when |
| ---------- | ----------- |
| **Release** (milestone) | You want named checkpoints (v0.1, v1.0) |
| **Feature** (deliverable) | You want to say what ships at each release |
| **Dependency** | Order matters between features |
| **Priority** | You must decide what ships now vs later |
| **Deadline** | Dates are fixed (sprint ends, public launch) |
| **Time** | You want cadence (e.g. one release per month) |

### 4. Assign the constraints to phases

- For each phase, attach the chosen constraints.
- Each **release** gets a **version** and a list of **features**.

### 5. Name the releases

- Give each release a version: `v0.1`, `v0.2`, `v1.0`.
- Optionally give it a name: `Kubernetes`, `First usable release`.

### 6. Choose a representation

| Representation | Best for |
| -------------- | -------- |
| **Table** | Precise planning, per-phase detail |
| **Tree** | Communicating the sequence at a glance |
| **Timeline** | Emphasizing cadence and deadlines |

### 7. Review and adjust

- Verify each release has a clear version and feature set.
- Verify the sequence matches the lifecycle.
- Adjust as the project evolves — a roadmap is a living representation.

## Worked example

A software project with an iterative lifecycle:

**Step 1 — lifecycle:** iterative (Development → Testing → Release, repeated)

**Step 2 — phases:** Development, Testing, Release

**Step 3 — constraints chosen:** Release, Version, Feature, Time

**Step 4–5 — assignments:**

| # | Phase | Release | Version | Feature |
| - | ----- | ------- | ------- | ------- |
| 1 | Development | First prototype | v0.1 | Core module |
| 2 | Testing | Stabilization | v0.9 | Bug fixes |
| 3 | Release | Public launch | v1.0 | Public launch |

**Step 6 — representation:** tree view

```
Software
   │
   └── Roadmap
        ├── v0.1 — Core module
        ├── v0.9 — Stabilization
        └── v1.0 — Public launch
```

## Common pitfalls

| Pitfall | Fix |
| ------- | --- |
| Confusing release and version | A release *has* a version — they are not the same |
| Treating features as constraints | Features are **properties** of a release |
| Skipping the lifecycle | A roadmap without a lifecycle has nothing to constrain |
| Over-specifying | Keep it high-level; details go in the plan and the schedule |

