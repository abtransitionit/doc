[//]: #(home)
[home]: ../whatis/ep.md

[//]: #(ref)
[phase whatis]: ../whatis/phase.md
[prj lfc whatis]: ../whatis/lfc.prj.md
[methodology list]: ../list/meth.ep
[prj lfc howto]: ../howto/ep.md
[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a phase][phase whatis]|internal
|[What is a project lifecycle][prj lfc whatis]|internal
|[How-To for project lifecycle][prj lfc howto]|internal




<h1 align="center">Project Roadmap</h1>

# Definition
- A **planned** sequence of outcomes **over time**
- Add constraints to the [lifecycle][prj lfc whatis], like:
- outcomes might be milestones, releases, dependencies, priorities, deadlmines, etc.
- Shows the progression of the project through time towards its objectives.
- Can be revised without changing the project's [lifecycle][prj lfc whatis].

**Example 01**:

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

**Example 03**:
```
t01 → v0.1 — Core concepts
t02 → v0.2 — Local filesystem provider
t03 → v0.3 — Remote host provider
t04 → v0.4 — VM provisioning
t05 → v0.5 — Container provisioning
t06 → v1.0 — Kubernetes
```

- While lifecycle defines a sequence of phases without imposing temporal constraints.
- A roadmap introduces temporal and planning constraints on that sequence.

