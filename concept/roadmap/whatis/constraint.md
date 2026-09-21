[//]: #(home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ./ep.md

[↖ Roadmap][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #(ref)
[lfc whatis]:     ../../lifecycle/whatis/ep.md
[rm project]:     ../kind/project/whatis/ep.md
[rm software]:    ../kind/software/whatis/ep.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
| [What is a roadmap][home topic]               | Internal | Parent |
| [What is a lifecycle][lfc whatis]              | Internal | Related |
| [What is a project roadmap][rm project]        | Internal | Kind |
| [What is a software roadmap][rm software]      | Internal | Kind |

<h1 align="center">What is a Roadmap Constraint</h1>

The concept of constraint (in a roadmap)

# Definition

## Constraint
- An **additional piece of information** attached to a [lifecycle][lfc whatis]'s phase.
- Turns a bare lifecycle into a [rm][home topic].
- Allows to track progression inside the lifecycle.
- Can have **properties** that are domain-specific.


# Generic constraints

These constraints may exist in any domain (e.g. project roadmap, software roadmap):

| Constraint | Role |
| ---------- | ---- |
| **Milestone** | A key checkpoint |
| **Deliverable** | What is produced at a checkpoint |
| **Dependency** | What must come before what |
| **Priority** | What matters most |
| **Deadline** | A fixed date |
| **Time** | Duration and horizon |

# Constraints and properties

A constraint may carry **properties**. The constraint is the *kind* of information;
the properties are the *details*.

| Constraint | Possible properties |
| ---------- | ------------------- |
| **Milestone** | name, date, deliverable |
| **Deliverable** | name, format, owner |
| **Dependency** | predecessor, successor |
| **Priority** | rank, reason |
| **Deadline** | date, reason |
| **Time** | duration, horizon |

# Domain-specific constraints

The generic constraints are the same everywhere. Each domain may:
- **rename** a generic constraint, and/or
- **add properties** to it.

## Project roadmap
See [project roadmap][rm project].

| Generic constraint | In a project |
| ------------------ | ------------ |
| Milestone | Phase gates — kickoff, beta, go-live |
| Deliverable | Project artifacts — charter, product, handover |

## Software roadmap
See [software roadmap][rm software].

| Generic constraint | In software |
| ------------------ | ----------- |
| Milestone → **Release** | v0.1, v1.0, public launch |
| Deliverable → **Feature** | Modules, artifacts shipped |
| Milestone properties | **Version**, name |

## Other domains

| Domain | Milestone renamed to |
| ------ | -------------------- |
| Career | Stage (Junior, Mid, Senior) |
| Product | Release |
| Company | Initiative |
| Document | Step |

# See also

- [What is a roadmap][home topic]
- [What is a lifecycle][lfc whatis]
- [What is a project roadmap][rm project]
- [What is a software roadmap][rm software]