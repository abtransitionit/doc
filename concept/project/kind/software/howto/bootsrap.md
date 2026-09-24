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
[lfc list]:     /concept/lifecycle/list/ep.md
[rm whatis]:    /concept/roadmap/list/ep.md
[poc whatis]:   /concept/test/whatis/ep.md

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
   1. [The lifecycle](#lfc)
   1. [Define the goal](#goal)
   1. [The Roadmap](#rm)
   1. Scope it (MVP)
   1. Set up the repo
   1. Set up tooling
   1. Set up version control workflow
   1. Set up CI/CD
   1. Define quality gates
   1. Write first docs
   1. Plan first tasks
   1. Start (first commit, first iteration)
1 | Worked example** — a small software project bootstrapped end-to-end
1 | Common pitfalls**

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

> Inputs marked ✗ are optional: if not provided, they are builed in a later stage


# [↑][home index] The Lifecycle <a id='lfc'></a>
[Pick up][lfc list] or create a lifecycle suitable for your project. what we called lifecycle is only the sequence of stage and a short description for each stage: Example you can define this one

|#|Stage Name|Description|
|-|-|-|
| 1 | Vision | Big picture / end goal
| 1 | Terminology | Define shared language and key terms |
| 3 | Requirements | Gather and document all needs.
| 3 | Design | Plan the architecture and specifications.
| 4 | Implementation | Build the product.
| 5 | Testing | Verify it works correctly.
| 6 | Maintenance | Fix issues and support after delivery.
Flow:

```
Vision → Terminology → Requirements → Design → Implementation → Testing → Maintenance
```


# [↑][home index] The Roadmap <a id='rm'></a>
Add constarints to get a [Roadmap][rm whatis] from this lifecycle

**constraint 01**: Each stage produces at least an output and an outcome.


Difference to keep clear:

- **Output** = what a stage *produces* (artifact, document, code)
- **Outcome** = what *changes* because of it (result, decision, readiness)

For the software project:

| # | Stage | Output | Outcome |
|---|---|---|---|
| 1 | Vision | Vision statement | Team aligned on the goal |
| 2 | Terminology | Glossary | Shared language, no ambiguity |
| 3 | Requirements | Requirements spec | Clear scope of what to build |
| 4 | Design | Design doc / architecture | Blueprint ready to code |
| 5 | Implementation | Working code | Feature exists and runs |
| 6 | Testing | Test report | Confidence it works |
| 7 | Maintenance | Patches / updates | Product stays usable over time |

We keep the same roadmap for the [POC and the MVC][poc whatis]


# [↑][home index] Step 1 — Define the goal <a id='goal'></a>

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

| ├──> └──> 
| ├──> └──> 
/doc/project/
├──> metadoc
├──> feca
└──> rpro