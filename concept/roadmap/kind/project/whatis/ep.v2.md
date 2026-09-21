[//]: #(home)
[home doc]:     ../../../README.md
[home topic]:  ../whatis/ep.md

[↖ Project][home topic] · [↖ Doc][home doc]

[//]: #(ref)
[lfc whatis]: ../../../concept/lifecycle/whatis/ep.md



<h1 align="center">What is a Project's Roadmap</h1>

The concept of project:roadmap

# Definition

- Add constraints to the [lifecycle][lfc whatis] of a project
- constraints might be milestones, releases, dependencies, priorities, deadlines, etc.
- Can be revised without changing the project's [lifecycle][home].
- Plans how we move through the lifecycle.
- Displays the project's progress over time towards its objectives.

## Key points

- While lifecycle defines a sequence of phases without imposing temporal constraints.
- A roadmap introduces temporal and planning constraints on that sequence.


## Example <a id='example'></a>


| Context          | Roadmap adds                                          |
| ---------------- | ----------------------------------------------------- |
| [Project](#project)   | Milestones, deadlines, dependencies                   |
| [Software](#software) | Releases, versions, features                          |
| [Product](#product)   | Releases, features, market objectives                 |
| [Organization](#organization) | Strategic objectives, initiatives, restructuring      |
| [Data](#data)         | Migration steps, retention deadlines, storage changes |
| [Document](#document) | Review dates, approval deadlines, publication dates   |


# Examples detailed

## [↑](#example) Software lifecycle <a id='software'></a>

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
## [↑](#example) Project lifecycle <a id='project'></a>

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

## [↑](#example) Product lifecycle <a id='product'></a>

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

## [↑](#example) Organization lifecycle <a id='organization'></a>
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
## [↑](#example) Data lifecycle <a id='data'></a>
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

## [↑](#example) Document lifecycle <a id='document'></a>

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








## Example <a id='example'></a>

| Context | Roadmap |
|-|-|
| Theoretical | `A` → `B` → `C` → `D`<br>`t1` → `t2` → `t3` → `t4` |
| Software | `v0.1` — Core features → `v0.2` — Testing → `v1.0` — Production release → `v2.0` — Major update |
| Project | `M1` — Initiation → `M2` — Planning → `M3` — First deliverable → `M4` — Completion |
| Product | `MVP` — Prototype → `v1.0` — Launch → `v1.1` — Improvements → `v2.0` — Major release |
| Organization | `M1` — Creation → `M2` — First team → `M3` — Expansion → `M4` — Restructuring |
| Data | `M1` — Data collection → `M2` — Processing pipeline → `M3` — Storage → `M4` — Archival |
| Document | `Draft` → `Review` → `Approval` → `Publication`<br>`t1` → `t2` → `t3` → `t4` |

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

