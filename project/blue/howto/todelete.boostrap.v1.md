Absolutely. I applied all the corrections above while preserving your current structure and terminology.

[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[lfc whatis]: /concept/lifecycle/whatis/ep.md
[poc whatis]: /concept/test/whatis/poc.md
[mvp whatis]: /concept/test/whatis/mvp.md
[rm constraint whatis]: /concept/roadmap/whatis/constraint.md
[prj whatis]: ../whatis/ep.md

Related topics

| Topic                            | Location | Kind |
| -------------------------------- | -------- | ---- |
| [What is a software project][prj whatis] | internal |      |

<h1 align="center">Project: Project Blueprint</h1>

a Software Project Management Blueprint

# Bootstrap a Software Project from the Blueprint

This tutorial explains how to create a new project from the Project Blueprint.

The goal is to create the initial project structure and establish its documentation source of truth.

## 1. Create the Project

Create a repository for the project.

```text
<project-name>/
```

The project is an instance of the Project Blueprint.

It inherits the blueprint's:

* Lifecycle
* Documentation structure
* Templates
* Naming conventions
* Quality gates
* Project management conventions

## 2. Create the Entry Point

The project entry point is:

```text
<project-name>/whatis/ep.md
```

This document introduces the project and provides navigation to its authoritative documentation.

It should not contain copies of information defined elsewhere.

Example:

```text
# Project Name

A short description of the project.

## Documentation

- [Vision](../01-vision/)
- [Terminology](../02-terminology/)
- [Discovery](../03-discovery/)
- [Requirements](../04-requirements/)
- [Specification](../05-specification/)
- [Design](../06-design/)
- [Architecture](../07-architecture/)
- [Development](../08-development/)
- [Validation](../09-validation/)
- [Release](../10-release/)
- [Operate & Evolve](../11-operate-evolve/)
```

The entry point answers:

> Where do I start?

It does not become a second source of truth.

## 3. Apply the Single Source of Truth Rule

Each important piece of information must have one authoritative location.

Other documents may reference it.

They should not duplicate it.

For example:

```text
01-vision/
├── vision.md
├── problem.md
├── goals.md
├── scope.md
└── success-criteria.md
```

The problem is defined in `problem.md`.

The goals are defined in `goals.md`.

The scope is defined in `scope.md`.

Other documents should link to these documents when needed.

Do not copy their contents.

This prevents conflicting information and synchronization problems.

## 4. Create the Lifecycle Structure

Create the lifecycle directories.

```text
<project-name>/

├── whatis/
│   └── ep.md
│
├── 01-vision/
├── 02-terminology/
├── 03-discovery/
├── 04-requirements/
├── 05-specification/
├── 06-design/
├── 07-architecture/
├── 08-development/
├── 09-validation/
├── 10-release/
└── 11-operate-evolve/
```

Do not create every document immediately.

Create documents when their information becomes relevant.

## 5. Define the Vision

Start with the Vision phase.

Create:

```text
01-vision/

├── vision.md
├── problem.md
├── goals.md
├── scope.md
└── success-criteria.md
```

Define:

* Why the project exists
* The problem
* The target users
* The desired outcome
* The goals
* The scope
* The success criteria

Each topic has one authoritative document.

The entry point should link to these documents.

It should not reproduce them.

## 6. Define the Terminology

Create the project vocabulary.

```text
02-terminology/

├── glossary.md
└── concepts/
```

Define important domain terms.

Use these definitions consistently throughout the project.

If a term has a dedicated concept document, reference that document instead of copying its definition.

## 7. Start Discovery

Create the Discovery documentation.

```text
03-discovery/

├── domain.md
├── users.md
├── requirements.md
├── assumptions.md
├── constraints.md
└── risks.md
```

Investigate the problem domain.

Record assumptions, constraints, and risks.

The purpose is to reduce important uncertainties.

Discovery may cause the project to revisit the Vision.

When this happens, update the authoritative document.

Do not create a second version elsewhere.

## 8. Define Requirements

Create:

```text
04-requirements/

├── functional.md
├── non-functional.md
├── business-rules.md
└── acceptance-criteria.md
```

Requirements define what the product must provide.

Keep requirements in the Requirements phase.

Later documents should reference them.

They should not redefine them.

## 9. Define the Specification

Create:

```text
05-specification/

├── product.md
├── features.md
├── use-cases.md
├── workflows.md
└── requirements.md
```

Define the product behavior in sufficient detail for implementation.

Reference requirements rather than duplicating them.

The specification should make the intended product clear.

## 10. Define the Design

Create:

```text
06-design/

├── product.md
├── workflows.md
├── interfaces.md
└── technical.md
```

Define how the specified product should work.

Keep product design separate from architectural decisions.

## 11. Define the Architecture

Create:

```text
07-architecture/

├── overview.md
├── components.md
├── principles.md
├── data.md
├── integrations.md
├── security.md
└── decisions/
```

Record significant architectural decisions as ADRs.

For example:

```text
decisions/

├── ADR-001-database.md
├── ADR-002-authentication.md
└── ADR-003-deployment.md
```

Architecture should be based on validated requirements and findings.

Avoid premature technical decisions.

## 12. Define the First Milestone

A project may use a PoC to validate important product or technical assumptions.

Create:

```text
poc/

├── objective.md
├── scope.md
├── features.md
├── implementation.md
├── target-delta.md
├── results.md
└── conclusion.md
```

The PoC should answer specific questions.

Build only what is required to obtain useful evidence.

Record the results.

Use those results to determine the next step.

## 13. Develop Incrementally

When the project is ready, start Development.

```text
08-development/

├── roadmap.md
├── milestones.md
├── backlog.md
├── iterations/
└── releases/
```

Use short development cycles:

```text
PLAN
  ↓
BUILD
  ↓
TEST
  ↓
DEMONSTRATE
  ↓
VALIDATE
  ↓
LEARN
```

Each increment should produce a demonstrable result.

## 14. Define the MVP

Define the target MVP.

```text
mvp/

├── definition.md
├── scope.md
├── features.md
├── implementation.md
├── acceptance-criteria.md
└── success-metrics.md
```

The MVP defines the minimum viable product.

Use PoC results to determine the work required to reach it.

Do not copy PoC information into the MVP.

Reference the relevant PoC results instead.

## 15. Validate the Product

Create:

```text
09-validation/

├── test-plan.md
├── test-results.md
└── acceptance.md
```

Validate the product against its authoritative requirements and acceptance criteria.

Check:

* Functionality
* Non-functional requirements
* Acceptance criteria
* Technical behavior
* Regression

Record the evidence and results.

## 16. Prepare the Release

Create:

```text
10-release/

├── readiness.md
├── checklist.md
├── deployment.md
├── rollback.md
└── release-notes.md
```

Prepare the validated product for production.

Record release-specific information here.

Do not duplicate requirements or architecture documentation.

Reference them when needed.

## 17. Operate and Evolve

After release, operate the product.

```text
11-operate-evolve/

├── monitoring.md
├── incidents.md
├── metrics.md
└── improvements.md
```

Monitor the product.

Handle incidents.

Measure outcomes.

Record improvements.

Use operational knowledge to drive future iterations.

## 18. Keep Information in One Place

When adding information, ask:

> Where is the authoritative location for this information?

If one already exists, update it.

Do not create another copy.

For example:

```text
Question: What is the project goal?

Answer:
01-vision/goals.md
```

Not:

```text
whatis/ep.md
01-vision/vision.md
03-discovery/domain.md
README.md
```

with four copies of the same goal.

Instead:

```text
whatis/ep.md
      │
      └── links to → 01-vision/goals.md
```

## 19. Add Quality Gates

Each major phase should have a quality gate.

A gate answers:

> Do we have enough evidence to proceed?

For example:

```text
VISION
  │
  ├── Problem defined?
  ├── Users identified?
  ├── Goals defined?
  └── Success criteria defined?
          │
          ▼
       GATE 01
          │
          ▼
     DISCOVERY
```

Quality gates should expose unresolved risks.

They should not be administrative checkpoints.

## 20. Commit the Initial Project

Commit the initial structure and documentation.

```bash
git add .
git commit -m "Bootstrap project"
```

The repository is now the project's source of truth.

## Result

A bootstrapped project has a clear entry point and lifecycle structure:

```text
<project-name>/

├── whatis/
│   └── ep.md
│
├── 01-vision/
├── 02-terminology/
├── 03-discovery/
├── 04-requirements/
├── 05-specification/
├── 06-design/
├── 07-architecture/
├── 08-development/
├── 09-validation/
├── 10-release/
└── 11-operate-evolve/
```

The entry point provides navigation.

Each important piece of information has one authoritative location.

The documentation evolves with the project.

The project progresses through the lifecycle as evidence becomes available.
