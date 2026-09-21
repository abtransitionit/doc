[//]: #(home)
[home domain]:    ../../../../README.md
[home doc]:    /README.md
[home topic]: ../howto/ep.md
[home index]: #index

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

<h1 align="center">Bootstrap a Software Project</h1>

The concept of software project

# 🔍 Navigation Index <a id='index'></a>

1. [Prerequisites](#prereq) - what you need before starting (idea, stakeholders, constraints)
1. [Steps](#steps)
   1. [Define the goal](#goal)
   1. Scope it (MVP)
   1. Choose the lifecycle
   1. Build the roadmap
   1. Set up the repo
   1. Set up tooling
   1. Set up version control workflow
   1. Set up CI/CD
   1. Define quality gates
   1. Write first docs
   1. Plan first tasks
   1. Start (first commit, first iteration)
1. **Worked example** — a small software project bootstrapped end-to-end
1. **Common pitfalls**

**Links I'll add** (refs to other files — some may not exist yet):
- `[prj software]` → `../whatis/ep.md` (this kind's whatis)
- `[rm software]` → `/concept/roadmap/kind/software/whatis/ep.md`
- `[lfc software]` → `/concept/lifecycle/kind/software/whatis/ep.md`
- `[rm howto]` → `/concept/roadmap/howto/ep.md` (generic roadmap howto)

---

**Two questions:**

1. Steps 5–10 (repo, tooling, VCS, CI/CD, quality, docs) — these are **tool-heavy** and stack-specific. Keep them in this file as **methodology-level** steps (generic), or push them to a separate file later?
2. Anything to add/remove from the 12-step list before I write?

Confirm, and I write the file.

# [↑][home index] Prerequisites <a id='prereq'></a>

Before bootstrapping, you need:

| Input | Mandatory | Default | Description |
| ----- | --------- | ------- | ----------- |
| **Code name** | ✓ | — | A short identifier for the project (e.g. `rpro`, `rctl`, `metadoc`) |
| **Idea** | ✓ | — | A problem worth solving, or a value worth producing |
| **Stakeholders** | ✓ | — | Who cares about the result — users, customers, team, sponsor |
| **Constraints** | ✗ | none | Budget, deadline, team size, technology, regulations |
| **Software lifecycle** | ✗ | iterative | The stages the project will go through — see [software lifecycle][lfc software] |
| **Software roadmap** | ✗ | empty | The constraints on those stages — see [software roadmap][rm software] |

> Inputs marked ✗ are optional: if you don't provide them, they **will be built
> during the bootstrap** — the lifecycle in Step 3, the roadmap in Step 4.
> The defaults above are only starting points.

| Input | Mandatory | Default | Description |
| ----- | --------- | ------- | ----------- |
| **Code name** | ✓ | — | A short identifier for the project (e.g. `rpro`, `rctl`, `metadoc`) |
| **Idea** | ✓ | — | A problem worth solving, or a value worth producing |
| **Stakeholders** | ✓ | — | Who cares about the result — users, customers, team, sponsor |
| **Constraints** | ✗ | none | Budget, deadline, team size, technology, regulations |
| **Software lifecycle** | ✗ | iterative | The stages the project will go through — see [software lifecycle][lfc software] |
| **Software roadmap** | ✗ | empty | The constraints on those stages — see [software roadmap][rm software] |

| Input | Description |
| ----- | ----------- |
| An **idea** | A problem worth solving, or a value worth producing |
| **Stakeholders** | Who cares about the result — users, customers, team, sponsor |
| **Constraints** | Budget, deadline, team size, technology, regulations |
| A [software lifecycle][lfc software] | The stages the project will go through |
| A [software roadmap][rm software] | The constraints on those stages |

> Only the **idea** and **stakeholders** are mandatory to start.
> Lifecycle and roadmap are built during bootstrap (see Step 3 and Step 4).

# [↑][home index] Step 1 — Define the goal

## What it is
- State **what problem** the project solves.
- State **for whom** — the users, customers, or stakeholders.
- State **why** — the value it produces.

## Why it matters
- Every later decision (scope, lifecycle, roadmap, tooling) depends on the goal.
- A vague goal produces a vague project.
- The goal is the reference you return to when trade-offs appear.

## How to do it
- Write one sentence: *"This project exists to … for … so that …"*
- Validate it against the stakeholders.
- Keep it short — one paragraph maximum.

## Output
- A written goal statement.

## Example

> *This project exists to provide a command-line tool that provisions
> and manages remote hosts for developers, so that infrastructure setup
> takes minutes instead of days.*

## Next
- Step 2 — Scope it (MVP).


# Questions left
- How to ensure that this new project fits into an existing project framework. We might want tracking each new projects for a  lot of reasons
    - statisctic and auditing
    - Later automation that does not exists at the day when creating the projects
