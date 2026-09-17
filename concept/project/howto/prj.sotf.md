[//]: #(home)
[home]: ../whatis/ep.md
[lfc whatis]:         ../../../concept/lifecycle/whatis/ep.md
[prj roadmap whats]:  ../../../concept/lifecycle/whatis/roadmap.md
[prj lfc whatis]:     ../../../concept/lifecycle/whatis/ep.md#sproject
[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Lifecycle][lfc whatis]|internal



<h1 align="center">How-to for Software Project</h1>



# Howto for Software project

Established a three-pillar knowledge structure:

**Project Hub** 
  - e.g. `/doc/project/rctl`
  - Tracks the evolution, architecture, specifications, ADRs, and implementation lifecycle of the software artifact itself (what we have been building so far).
  - governs engineering lifecycle decisions
  - [directory layout](../whatis/layout.md)
  - internal engineering artifacts (architecture, specs, ADRs, task logs, and the active execution board).

**Tool Hub** 
  - e.g. `/doc/tool/rctl`
  - Holds operator-facing documentation, user manuals, administration references, and operational how-tos for people using rctl.
  - provides runtime knowledge for end-users, operators, and administrators.
  - [directory layout](../whatis/layout.md)
  - end-users, operators, and sysadmins (guides, CLI references, security rules).
**Execution Board**: 
  - The operational view for tracking tasks, milestones, and active sprint/phase work.
  - Sits alongside the Project and Tool hubs to manage active execution state.


 # Link tool <-> project

 - Certain Tool Hub documents may be linked to Project Hub documents
 - It happens when deeper architectural or governance context is required.

## Linking Principle

* **Tool Hub $\rightarrow$ Project Hub:** Valid for users seeking deep technical context, rationale, or formal specs.
* **Project Hub $\rightarrow$ Tool Hub:** Rarely necessary, except in execution tasks that require creating or updating user-facing documentation.
## Examples of link

## Links from **Tool Hub** to **Project Hub**

- Tool Hub means for example `/doc/tool/rctl/`
- Project Hub means for example `/doc/project/rctl/`

`doc/tool/rctl/admin/security.md` $\rightarrow$ `doc/project/rctl/adr/ADR-03-statutory-non-root-local-scope.md**`
* **Purpose:** The guide explains *how* the local non-root boundary behaves, while linking to **ADR-03** to explain the *architectural justification and security constraints* behind that design choice.


`doc/tool/rctl/ref/cli-reference.md` $\rightarrow$ `doc/project/rctl/adr/ADR-02-decoupled-output-formatting.md**`
* **Purpose:** The CLI reference lists the available output flags (`--json`, table view), linking to **ADR-02** for the design pattern decoupling presentation from execution streams.


`doc/tool/rctl/whatis/overview.md` $\rightarrow$ `doc/project/rctl/spec/RFC-01-vision.md` & `SPEC-01-architecture.md**`
* **Purpose:** The overview introduces what `rctl` is, referencing the high-level Vision (`RFC-01`) and System Architecture (`SPEC-01`) for readers wanting the complete engineering specifications.




