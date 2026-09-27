[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[lfc whatis]: /concept/lifecycle/whatis/ep.md
[poc whatis]: /concept/test/whatis/poc.md
[mvp whatis]: /concept/test/whatis/mvp.md
[rm constraint whatis]: /concept/roadmap/whatis/constraint.md
[bootsrap howto]:  ../howto/boostrap.md

Related topics

| Topic                            | Location | Kind |
| -------------------------------- | -------- | ---- |
| [Whatis a Lifecycle][lfc whatis] | internal |      |
| [How-to bootsrap a software project][bootsrap howto] | internal |      |


<h1 align="center">Project: Project Blue</h1>

A Software Project Management Blueprint


<h1 align="center">Project: Project Blue</h1>

A Software Project Management Blueprint

# 1. Purpose

Defines a reusable **project model** that can be **instantiated** to create software projects.

The project model defines a path from **vision** to **production release and evolution**, covering:

* Project lifecycle with initial **vision and goals**
* Artifacts to produce at each phase of the lifecycle
* Lifecycle constraints (e.g. milestones, quality gates)
* Decision mechanisms (🚧)
* Project management conventions (🚧)
* Project standards (🚧)
* Validation and delivery practices (🚧)
* Relationships between artifacts (🚧)
* Project evolution and progression through roadmap**
* Iterative development
* [PoC][poc whatis] and [MVP][mvp whatis] validation

> 🚀 **Note:** The blueprint is independent of the physical representation of the project (e.g. files, DB, tool).

> 🚀 **Note:** The blueprint is independent of the mechanism used to instantiate it (e.g. manually, tool).

## How it works

* The blueprint is designed to be **instantiated for individual projects**.
* Each project contains the **project-specific** information.


# 2. The Project Model

The project model aims to:

* Define a consistent **project lifecycle**.
* Define the **artifacts and relationships** used to manage a project.
* Provide clear **decision points, milestones, and quality gates**.
* Encourage **early validation** through PoCs and MVPs.
* Maintain a **single source of truth** for project information.
* Make project **status, decisions, risks, and progress** transparent.
* Keep **product, business, and technical concerns** clearly separated.
* Support projects of different **sizes and levels of complexity**.
* Allow different **artifact representations and storage mechanisms**.
* Support different mechanisms for **project instantiation**.


# 3. Artifact Representation

The blueprint does not prescribe how project artifacts are physically represented.

The representation is chosen when the project model is **instantiated**.

> **Note:** The representation may change during the lifetime of a project without changing the underlying project model.
>
> For example, a project may initially represent its artifacts as Markdown files and later migrate them to a database.


The representation is chosen when the project model is **instantiated**.

> 🌐 choice: A project instance may represent its artifacts using a single document, multiple documents, structured files, database records, or another suitable representation.


For example, a Vision artifact may be represented as:

* A section in a document
* A Markdown file
* A structured file
* A database record
* A record managed through a project management tool

These representations are different implementations of the same logical artifact.

# 4. Project Instantiation

**Instantiating** the blueprint creates a real software project instance.

During instantiation, project-specific information and implementation choices are established.

These choices may include:

* Project identity
* Project-specific artifacts
* Artifact representation
* Storage mechanism
* Access mechanism
* Project tooling

# 5. Objectives

The blueprint aims to:

* Define a consistent **project lifecycle**.
* Define the **artifacts and relationships** used to manage a project.
* Provide clear **decision points, milestones, and quality gates**.
* Encourage **early validation** through PoCs and MVPs.
* Maintain a **single source of truth** for project information.
* Make project **status, decisions, risks, and progress** transparent.
* Keep **product, business, and technical concerns** clearly separated.
* Support projects of different **sizes and levels of complexity**.
* Allow different **artifact representations and storage mechanisms**.
* Support different mechanisms for **project instantiation**.

# 6. Core Principles

## 6.1 Single Source of Truth

Each important piece of project information must have one **authoritative location**.

Other artifacts may reference authoritative information.

They should not maintain independent copies of the same information.

The physical location of the information depends on the project's chosen representation.

## 6.2 Explicit Decisions

Significant product and technical decisions should be documented.

An architectural or technical decision should capture:

* Context
* Problem
* Options considered
* Decision
* Rationale
* Consequences

Decisions provide a **traceable history** of the choices that shape the project.

## 6.3 Incremental Delivery

Projects should progress through **small, measurable increments**.

Each increment should:

1. Define a clear objective.
2. Produce a demonstrable result or deliverable.
3. Be validated against its intended outcome.
4. Feed results and learnings into the next increment.

This allows the project to adapt its scope, priorities, and implementation based on validated information.

# 7. Project Lifecycle

The blueprint defines the following lifecycle:

1. Vision
2. Terminology
3. Discovery
4. Requirements
5. Specification
6. Design
7. Architecture
8. Development
9. Validation
10. Release
11. Operate & Evolve

The lifecycle is **iterative**.

A project may return to an earlier stage when new information, validation results, or changes require it.

Each lifecycle stage defines:

* Objective
* Activities
* Expected artifacts
* Exit criteria

The lifecycle describes the **logical progression of project work**. It does not prescribe a physical representation of the project.

# 8. Vision

## Objective

Establish why the project exists and what it intends to achieve.

## Activities

* Define the vision.
* Describe the problem.
* Define goals.
* Establish scope.
* Define success criteria.

## Expected Artifacts

* Vision
* Problem
* Goals
* Scope
* Success criteria

## Exit Criteria

The project has a clear purpose, intended outcome, scope, and initial definition of success.

# 9. Terminology

## Objective

Establish a shared vocabulary for the project.

## Activities

* Identify important terms.
* Define domain concepts.
* Resolve ambiguous terminology.
* Maintain consistent terminology.

## Expected Artifacts

* Glossary
* Concepts

## Exit Criteria

Important project terminology is defined and understood.

# 10. Discovery

## Objective

Understand the problem domain, users, constraints, assumptions, and risks.

## Activities

* Explore the domain.
* Identify users and stakeholders.
* Discover requirements.
* Identify assumptions.
* Identify constraints.
* Identify risks.

## Expected Artifacts

* Domain
* Users
* Requirements
* Assumptions
* Constraints
* Risks

## Exit Criteria

The project has sufficient understanding of its context and major uncertainties.

# 11. Requirements

## Objective

Define what the project must achieve.

## Activities

* Define functional requirements.
* Define non-functional requirements.
* Define business rules.
* Define acceptance criteria.

## Expected Artifacts

* Functional requirements
* Non-functional requirements
* Business rules
* Acceptance criteria

## Exit Criteria

Requirements are sufficiently defined to guide specification and validation.

# 12. Specification

## Objective

Define the intended product behavior in sufficient detail to guide design and implementation.

## Activities

* Define the product.
* Define features.
* Define use cases.
* Define workflows.
* Relate the specification to requirements.

## Expected Artifacts

* Product specification
* Features
* Use cases
* Workflows
* Requirement relationships

## Exit Criteria

The intended product behavior is sufficiently specified.

# 13. Design

## Objective

Define how the product should behave and interact.

## Activities

* Define product behavior.
* Define workflows.
* Define interfaces.
* Define technical design.

## Expected Artifacts

* Product design
* Workflows
* Interfaces
* Technical design

## Exit Criteria

The design is sufficiently defined to support architectural decisions and implementation.

# 14. Architecture

## Objective

Define the technical structure of the system.

## Activities

* Define the architecture.
* Define components.
* Define architectural principles.
* Define data structures.
* Define integrations.
* Define security considerations.
* Record significant architectural decisions.

## Expected Artifacts

* Architecture overview
* Components
* Principles
* Data
* Integrations
* Security
* Architecture decisions

## Exit Criteria

The architecture is sufficiently defined to support implementation.

# 15. Development

## Objective

Build the product through incremental delivery.

## Activities

* Plan work.
* Define milestones.
* Maintain the backlog.
* Execute iterations.
* Build increments.
* Test increments.
* Demonstrate results.
* Validate outcomes.
* Learn and adapt.

The development cycle is:

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
  ↓
NEXT ITERATION
```

## Expected Artifacts

* Roadmap
* Milestones
* Backlog
* Iterations
* Releases
* PoCs
* MVP

## Exit Criteria

The required product increment has been implemented and is ready for validation.

# 16. PoC

A **Proof of Concept (PoC)** is a milestone used to reduce uncertainty.

A PoC may use a simplified implementation or temporary technology.

Its purpose is to answer a specific question with the minimum necessary effort.

A PoC may investigate:

* Product value
* Workflow
* User behavior
* Features
* Assumptions
* Technical viability
* Integrations

A PoC should define:

* Objective
* Scope
* Features or capabilities
* Implementation
* Target delta
* Results
* Conclusion

Possible outcomes include:

* Validated
* Invalidated
* Partially validated
* Requires further investigation

PoC results should feed back into the relevant project artifacts.

# 17. MVP

An **MVP** represents the minimum viable implementation required to validate the intended product.

The MVP should define:

* Target users
* Core problem or workflow
* Required features
* Excluded features
* Technical capabilities
* Acceptance criteria
* Success metrics

PoC results and other validation results should inform the MVP definition.

The MVP is a project milestone, not a separate project model.

# 18. Validation

## Objective

Determine whether the implementation satisfies its intended requirements and outcomes.

## Activities

* Define validation activities.
* Execute tests.
* Evaluate results.
* Perform acceptance.
* Record findings.

## Expected Artifacts

* Test plan
* Test results
* Acceptance results

## Exit Criteria

The implementation has been evaluated against the applicable requirements and acceptance criteria.

# 19. Release

## Objective

Prepare and deliver a validated product increment for use.

## Activities

* Evaluate release readiness.
* Complete release checks.
* Prepare deployment.
* Prepare rollback.
* Publish release information.

Release readiness should consider applicable areas such as:

* Feature completeness
* Testing
* Security
* Performance
* Documentation
* Configuration
* Deployment
* Monitoring
* Backup and recovery
* Rollback
* Operational ownership

## Expected Artifacts

* Readiness
* Release checklist
* Deployment
* Rollback
* Release notes

## Exit Criteria

The release is ready for its intended environment and has an appropriate operational plan.

# 20. Operate & Evolve

## Objective

Operate the released product and continuously improve it.

## Activities

* Monitor the product.
* Manage incidents.
* Measure results.
* Identify improvements.
* Validate changes.
* Release improvements.

The cycle is:

```text
OPERATE
   ↓
LEARN
   ↓
EVOLVE
   ↓
RELEASE
   ↓
OPERATE
```

There is no permanent exit from this stage.

## Expected Artifacts

* Monitoring
* Incidents
* Metrics
* Improvements

# 21. Roadmap and Milestones

A **roadmap** defines the intended evolution of the project.

A **milestone** represents a significant point or objective in that evolution.

Milestones may include:

* PoC
* MVP
* Release
* Dependency
* Priority
* Deadline
* Other project-specific constraints

Milestones and roadmap constraints should be traceable to the relevant project objectives.

# 22. Quality Gates

A **quality gate** determines whether the project has sufficient evidence to proceed.

Each major lifecycle transition should have an applicable quality gate.

A quality gate should answer:

> **Do we have enough evidence to proceed?**

Quality gates should prevent progression when critical uncertainties or required conditions remain unresolved.

They are not administrative checkpoints.

# 23. Project Status

A project should expose its current state clearly.

Status information may include:

* Lifecycle state
* Current milestone
* Version
* Health

Lifecycle state and project health are separate concepts.

For example:

```text
STATUS: DEVELOPMENT
MILESTONE: MVP
VERSION: 0.3
HEALTH: ON_TRACK
```

The physical representation of status is determined during instantiation.

# 24. Project Information Management

Project information should be:

* Version controlled where appropriate
* Structured consistently
* Traceable to decisions
* Accessible to relevant stakeholders
* Kept current as the project evolves

The project instance is the **source of truth for project-specific information**.

The blueprint is the **source of truth for the project model**.

Project-specific information should not be duplicated across independent artifacts.

# 25. Project Instance

A project instance is a concrete realization of the blueprint.

It contains project-specific information such as:

* Vision
* Requirements
* Decisions
* Architecture
* Implementation
* Validation results
* Metrics
* Releases
* Operational information

The project instance follows the project model while remaining adaptable to its specific context.

The blueprint does not contain project-specific information.

# 26. Instantiation and Representation

The blueprint defines the logical project model.

Instantiation determines how that model becomes a concrete project.

Instantiation may determine:

* Project identity
* Artifact representation
* Storage
* Access
* Tooling
* Project-specific configuration

The same project model may therefore be instantiated using different representations or technologies.

For example:

```text
                    Blueprint
                        │
                        ▼
                  Project Model
                        │
              ┌─────────┼─────────┐
              │         │         │
              ▼         ▼         ▼
           Markdown   Database   Application
              │         │         │
              └─────────┼─────────┘
                        ▼
                 Project Instance
```

# 27. Documentation and Publication

Documentation is one possible representation of project information.

When documentation is used, the project may provide an entry point for navigation.

For example:

```text
<project-name>/whatis/ep.md
```

The entry point should provide navigation to authoritative project information.

It should not duplicate information that already has an authoritative location.

The tools used to render, publish, search, or browse project information are implementation choices.

For example, Markdown may be rendered into documentation using a documentation system such as Algernon.

The rendering mechanism does not change the project model.

# 28. Blueprint and Implementation

The blueprint defines the **logical project model**.

An implementation provides a concrete way to instantiate and manage that model.

An implementation may define:

* Physical artifact representation
* Storage
* User interfaces
* APIs
* Templates
* Generators
* Validation tooling
* Rendering
* Publication

These implementation details must not be confused with the project model itself.

This separation allows the same blueprint to support different project environments and future tooling.

# 29. Blueprint Repository

A repository containing the blueprint is itself an implementation of the blueprint definition.

It may contain:

* Blueprint definition
* Principles
* Lifecycle definitions
* Artifact definitions
* Templates
* Standards
* Examples
* Implementation guidance

The structure of the blueprint repository is not part of the logical project model.

# 30. Definition of Done

The blueprint is operational when:

* A new project can be instantiated from it.
* The project model is clearly defined.
* The lifecycle is defined.
* Project artifacts and their relationships are defined.
* Major lifecycle stages have objectives and exit criteria.
* Quality gates are defined.
* Project status can be represented.
* The single-source-of-truth principle is defined.
* The blueprint is independent of a specific artifact representation.
* Different instantiation mechanisms can be used.
* A concrete implementation can provide the required project capabilities.
* The blueprint can be used without additional undocumented rules.

# 31. Guiding Model

The blueprint should allow a project to answer four fundamental questions:

```text
WHY
Why does the project exist?

WHAT
What must the project achieve?

HOW
How will it be designed, built, and delivered?

HOW DO WE KNOW?
How do we validate that it works and achieves its intended outcome?
```

These questions provide the foundation for the project model and its lifecycle.

### What changed

The important structural shift is now complete:

```text
Blueprint
    │
    ▼
Project Model
    │
    ├── Lifecycle
    ├── Artifacts
    ├── Relationships
    ├── Decisions
    ├── Milestones
    ├── Quality gates
    └── Management rules
    │
    ▼
Instantiation
    │
    ├── Representation
    ├── Storage
    ├── Access
    └── Tooling
    │
    ▼
Project Instance
```

The old **Markdown/file/repository structure is no longer the definition of a project**. It is now an implementation possibility.

That gives us the flexibility you were looking for: the same blueprint could eventually be instantiated by a manual Markdown workflow, a generator, a database-backed application, or another tool without changing the underlying project model.


# Todo

The blueprint therefore defines **what information exists and how it relates**, while **the instantiation determines where and how that information is stored and accessed**.



# Todo
# Definition

## Artifact

A piece of information.

Examples include:

* Phase:Vision
* Goal
* Requirement
* Feature
* Use case
* Software:Architecture:doc
* Decision
* Risk
* Milestone
* Software:Release:doc
* Validation result
