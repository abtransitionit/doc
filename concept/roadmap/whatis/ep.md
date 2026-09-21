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

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a Roadmap Constraint][rm constraint whatis]              | Internal | Member |
| [What is a lifecycle][lfc whatis]              | Internal | Related |
| [What is a project][project whatis]            | Internal | Uses |
| [What is a project roadmap](../kind/project/whatis/ep.md) | Internal | Kind |
| [What is a software roadmap](../kind/software/whatis/ep.md) | Internal | Kind |
| [How-to for roadmap][rm howto] | Internal | Kind |

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

- A roadmap can apply to many **domains**. 
- Each roadmap uses the same base concept: constraints on lifecycle phases

**Career roadmap**

- **Phases** are career lifecycle stages.
- **constraints** are skills, roles, and time.

| # | Phase | Skill / Role | Horizon |
| - | ----- | ------------ | ------- |
| 1 | Junior | Learn fundamentals | 1–2 years |
| 2 | Mid | Own features | 2–4 years |
| 3 | Senior | Lead projects | 4–7 years |

**Product roadmap**

- **Phases** are product lifecycle stages.
- **constraints** are features, releases, and priorities.

| # | Phase | Feature | Release |
| - | ----- | ------- | ------- |
| 1 | Discovery | Research | — |
| 2 | Build | Core features | v1.0 |
| 3 | Grow | Scale features | v2.0 |

**Company roadmap 01**

- **Phases** are company lifecycle stages.
-  **constraints** are goals, milestones, and time.

| # | Phase | Goal | Milestone |
| - | ----- | ---- | --------- |
| 1 | Seed | Product-market fit | First paying customers |
| 2 | Growth | Scale revenue | Break-even |
| 3 | Mature | Expand markets | New region launched |


**Company roadmap 02**

```
Organization
   │
   └── Roadmap
        ├── Initiative 01 → Define strategic objectives
        ├── Initiative 02 → Establish organizational structure
        ├── Initiative 03 → Develop new capabilities
        ├── Initiative 04 → Expand operations
        ├── Initiative 05 → Optimize processes
        └── Initiative 06 → Organizational transformation
```

**Projectc roadmap**
See [project roadmap](../kind/project/whatis/ep.md).

**Software roadmap 01**
- A software roadmap is the roadmap whose subject is a software.
- **Phases** are software lifecycle stages.
- **constraints** are features, versions, and releases.

See [software roadmap](../kind/software/whatis/ep.md).

| # | Phase | Feature | Version |
| - | ----- | ------- | ------- |
| 1 | Development | Core module | v0.1 |
| 2 | Testing | Stabilization | v0.9 |
| 3 | Release | Public launch | v1.0 |



**Software roadmap 02**

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

**Software roadmap 03**

```
Product
   │
   └── Roadmap
        ├── Release 01 → Initial product
        ├── Release 02 → Core features
        ├── Release 03 → User feedback improvements
        ├── Release 04 → Advanced features
        ├── Release 05 → Performance improvements
        └── Release 06 → Major product release
```

**Data roadmap 03**
```
Data
   │
   └── Roadmap
        ├── Step 01 → Define data requirements
        ├── Step 02 → Create data model
        ├── Step 03 → Implement data processing
        ├── Step 04 → Migrate existing data
        ├── Step 05 → Establish retention policies
        └── Step 06 → Archive or delete obsolete data
```

**Document roadmap 03**

```
Document
   │
   └── Roadmap
        ├── Step 01 → Create initial draft
        ├── Step 02 → Complete review
        ├── Step 03 → Obtain approval
        ├── Step 04 → Publish document
        ├── Step 05 → Review periodically
        └── Step 06 → Archive document

```





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


