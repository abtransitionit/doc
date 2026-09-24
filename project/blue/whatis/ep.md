[//]: #(home)
[home domain]: ../../README.md
[home doc]:     ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: #(doc)
[lfc whatis]: /concept/lifecycle/whatis/ep.md
[poc whatis]: /concept/test/whatis/poc.md
[mvp whatis]: /concept/test/whatis/mvp.md
[rm constraint whatis]: /concept/roadmap/whatis/constraint.md


Related topics

| Topic | Location | Kind |
|-|-|-|
|[Whatis a Lifecycle][lfc whatis]|internal|

<h1 align="center">Project: Project Blueprint</h1>

a Software Project Management Blueprint

# 1. Purpose

A framework for **defining, planning, executing, documenting, and delivering software projects**.

The blueprint framework provides a step by step guideline to go from **vision** to **production release**:

* Initial **vision and goals**
* **Project evolution and roadmap**
* Iterative development
* Validation and decision points
* Tracking of [PoC][poc whatis] and [MVP][mvp whatis] to **progressively** demonstrate product value.
* **Production release and evolution**

The blueprint is designed to be **instantiated for individual projects**. Each project inherits the blueprint's structure, principles, documentation standards, and lifecycle while remaining adaptable to its specific needs.

# 2. Objectives

The blueprint aims to:

* Provide a **repeatable project lifecycle**.
* Turn an initial idea into an **executable project**.
* Define clear **decision points, milestones, and deliverables**.
* Encourage **early validation** through PoCs and MVPs.
* Maintain a **consistent source of project documentation**.
* Make project **status, decisions, risks, and progress** transparent.
* Keep **product, business, and technical concerns** clearly separated.
* Support projects of different **sizes and levels of complexity**.
* Enable new projects to be created from a **consistent template**.


# 3. Core Principles

The blueprint is based on the following principles.


## 3.1 Explicit Decisions

Significant product and technical decisions must be documented using **Architecture Decision Records (ADRs)**.

Each ADR should capture:

* Context
* Problem
* Options considered
* Decision
* Rationale
* Consequences

ADRs provide a **traceable history of the decisions** that shape the project and its architecture.

## 3.2 Incremental Delivery

The project should use **Agile** pethodology: Progress through **small, measurable increments**. 

Each increment should:

1. Define a clear objective.
2. Produce a demonstrable result or deliverable.
3. Be validated against its intended outcome.
4. Feed the results and learnings into the next increment.

This allows the project to continuously adapt its scope, priorities, and implementation based on validated information.


# 4. Project Lifecycle

The blueprint defines a standardized [lifecycle][lfc whatis] for taking a software project from initial vision to production and continuous evolution.

| #  | Phase                | Description                                                                                    |
| -- | -------------------- | ---------------------------------------------------------------------------------------------- |
| 1  | **Vision**           | Define the problem, target users, goals, and desired outcomes.                                 |
| 2  | **Terminology**      | Establish the shared vocabulary, domain concepts, and definitions used throughout the project. |
| 3  | **Discovery**        | Explore the domain, existing solutions, assumptions, constraints, and risks.                   |
| 4  | **Requirements**     | Define what the product must provide, including functional and non-functional requirements.    |
| 5  | **Specification**    | Structure the requirements into product scope, use cases, workflows, and expected behavior.    |
| 6  | **Design**           | Define the product and technical design required to implement the specified solution. |
| 7  | **Architecture**     | Define the technical structure and key architectural decisions.                                |
| 8  | **Development**      | Iteratively build, test, and evolve the product.                                               |
| 9 | **Validation**       | Verify that the product meets its requirements and intended outcomes.                          |
| 10 | **Release**          | Prepare, deploy, and document a production release.                                            |
| 11 | **Operate & Evolve** | Monitor, maintain, measure, and continuously improve the product.                              |

This lifecycle represents the **evolution of a project**, not necessarily a strictly linear process. The project may revisit an earlier phase when new information, risks, or assumptions require further investigation.

Project knowledge, requirements, decisions, and outcomes are documenteded in the project documentation and should **evolve alongside the project**.

## 4.1 Phase → Vision

**Objective**

Define why the project exists and what outcome it is intended to achieve.

**Key Questions**

* What problem are we solving?
* Who experiences this problem?
* Why is solving it valuable?
* What is the desired outcome?
* What does success look like?
* What is explicitly outside the scope?

**Expected Deliverables**

```text
vision.md
problem.md
goals.md
scope.md
success-criteria.md
```

**Exit Criteria**

The project has a sufficiently clear problem, target outcome, and initial scope to proceed to discovery.

## 4.2 Phase → Terminology

**Objective**

Establish a shared vocabulary and define the domain concepts used throughout the project.

**Expected Deliverables**

```text
terminology/
├── glossary.md
└── concepts/
```

**Exit Criteria**

The key domain terms and concepts are defined and consistently understood.

## 4.3 Phase → Discovery

**Objective**

Understand the problem domain and identify the assumptions that could invalidate the project.

**Activities**

* Domain analysis
* User analysis
* Existing solution analysis
* Requirement discovery
* Constraint identification
* Risk identification
* Assumption mapping

**Expected Deliverables**

```text
discovery/
├── domain.md
├── users.md
├── requirements.md
├── assumptions.md
├── constraints.md
└── risks.md
```

**Exit Criteria**

The major product, technical, and business uncertainties have been identified.

## 4.4 Phase → Requirements

**Objective**

Define what the product must provide and the constraints it must satisfy.

**Expected Deliverables**

```text
requirements/
├── functional.md
├── non-functional.md
├── business-rules.md
└── acceptance-criteria.md
```

**Exit Criteria**

The requirements are sufficiently defined, traceable, and testable to proceed to specification.


## 4.5 Phase → Specification

**Objective**

Translate the project vision and discovery results into a sufficiently precise product definition.

**Expected Deliverables**

```text
specification/
├── product.md
├── features.md
├── use-cases.md
├── workflows.md
└── requirements.md
```

The specification should distinguish between:

* Functional requirements
* Non-functional requirements
* Constraints
* Business rules
* User expectations

**Exit Criteria**

There is enough product definition to determine what must be validated and what must be built.

## 4.6 Phase → Design

**Objective**

Define the product and technical design required to transform the specification into an implementable solution.

**Expected Deliverables**

```text
design/
├── product.md
├── workflows.md
├── interfaces.md
└── technical.md
```

**Exit Criteria**

The solution is sufficiently designed to define its architecture and implementation approach.


## 4.7 Phase → Architecture

**Objective**

Define the technical structure of the system/product to build and record the key architectural decisions.

Architecture should be driven by validated requirements and PoC findings rather than premature technical preferences.

Architecture decisions should be recorded using Architecture Decision Records (**ADRs**).

**Expected Deliverables**

```text
architecture/
├── overview.md
├── components.md
├── principles.md
├── data.md
├── integrations.md
├── security.md
└── decisions/
    ├── ADR-001-database.md
    ├── ADR-002-authentication.md
    └── ADR-003-deployment.md
```


**Exit Criteria**

The architecture is sufficiently defined to support implementation and the required architectural decisions are documented.


## 4.8 Phase → Development

**Objective**

Build the product through incremental implementation and continuous testing.


Build the product incrementally while continuously validating its requirements and architecture.

Development should be organized around **deliverable increments** rather than purely technical tasks.

Each increment should ideally produce something demonstrable.


**Typical Cycle**

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

**Activities**

* Implementation
* Integration
* Testing
* Refactoring
* Incremental delivery


**Expected Deliverables**

```text
development/
├── roadmap.md
├── milestones.md
├── backlog.md
├── iterations/
└── releases/
```

**Exit Criteria**

The planned increment or release scope is implemented and ready for validation.



## 4.9 Phase → Validation

**Objective**

Verify that the product satisfies its requirements and intended outcomes.

Verify that the product satisfies its defined requirements and provides the intended outcome.

**Activities**

Validation should cover multiple dimensions:

* Functional validation
* Non-functional validation
* Acceptance testing
* Technical validation
* Regression testing

And also

* Functional correctness
* Technical correctness
* Performance
* Security
* Usability
* Reliability
* Operational readiness

**Expected Deliverables**

```text
validation/
├── test-plan.md
├── test-results.md
└── acceptance.md
```

**Exit Criteria**

The release scope has been validated against its defined requirements and acceptance criteria.



## 4.10 Phase → Release

**Objective**

Prepare and deliver 
- a validated product increment to production.
- production-ready version of the product.


**Activities**

* Release preparation
* Deployment
* Release documentation
* Rollback preparation

**Expected Deliverables**

```text
release/
├── readiness.md
├── checklist.md
├── deployment.md
├── rollback.md
└── release-notes.md
```


**Release Checklist**

A release should address, where applicable:

* Feature completeness
* Testing
* Security
* Performance
* Documentation
* Configuration
* Deployment
* Monitoring
* Backup and recovery
* Rollback strategy
* Operational ownership

**Exit Criteria**

The release is deployed successfully and the required production documentation is available.


## 4.11 Phase → Operate & Evolve

**Objective**

Operate the product in production and use feedback, measurements, and operational knowledge to drive its evolution.

The project does not necessarily end at release.

Once deployed, the product enters an operational and evolutionary phase.

```text
RELEASE
   │
   ▼
OPERATE
   │
   ├── MONITOR
   ├── MAINTAIN
   ├── MEASURE
   └── LEARN
          │
          ▼
       ITERATE
```

**Activities**

Post-release activities may include:

* Monitoring
* Incident management
* Maintenance
* User feedback
* Product analytics
* Performance analysis
* Performance optimization
* Security updates
* New feature development
* Continuous improvement


**Expected Deliverables**

```text
operation/
├── monitoring.md
├── incidents.md
├── metrics.md
└── improvements.md
```

**Exit Criteria**

- There is no permanent exit criteria for this phase. 
- The project continues through **operate → learn → evolve → release** cycles.


# 5. Roadmap Constraints

The roadmap combines the **project lifecycle** with [constraints][rm constraint whatis].
* It defines **how the project progresses**.
* It provides a **clear view of the project's evolution**.

This framework defines **milestones** as a type of [constraint][rm constraint whatis] applied to the project [lifecycle][lfc whatis].


```text
Milestones
├── PoC
├── MVP
└── Release(s)
```

Projects may define additional milestones, properties, or other constraints as required.

Each constraint may also define its own **properties** to provide the information required to track and manage it.

The roadmap therefore follows this structure:

```text
Roadmap
└── Constraints
    ├── Milestone
    │   ├── PoC
    │   ├── MVP
    │   └── Release(s)
    │
    ├── Dependency
    ├── Priority
    ├── Deadline
    └── ...
```

# 6. Proof of Concept (PoC)

**Objective**

The [PoC][poc whatis] as **milestone** validate technical feasibility and reduce technical uncertainty.


**Typical PoC Questions**

* Is the required technology suitable?
* Can the architecture support the required workload?
* Can external systems be integrated?
* Can the required performance be achieved?
* Are there unexpected technical constraints?
* Is the proposed approach viable?

**PoC Deliverables**

```text
poc/
├── objective.md
├── hypotheses.md
├── experiments.md
├── results.md
└── conclusion.md
```

**Possible Outcomes**

A PoC should result in one of the following:

```text
VALIDATED
INVALIDATED
PARTIALLY_VALIDATED
REQUIRES_FURTHER_INVESTIGATION
```

A failed PoC is considered a successful project outcome when it prevents unnecessary investment in an invalid technical approach.

# 7. Minimum Viable Product (MVP)

**Objective**

The [MVP][mvp whatis] as a **milestone** validate the core product proposition.

**Definition**

The MVP should explicitly define:

* Target users
* Core problem
* Core workflow
* Required features
* Excluded features
* Acceptance criteria
* Success metrics

**Expected Deliverables**

```text
mvp/
├── definition.md
├── scope.md
├── features.md
├── acceptance-criteria.md
└── success-metrics.md
```


# 8. Project Instance Model

The blueprint itself is **not a project**.

It is a template from which projects are created.

Conceptually:

```text
BLUEPRINT
    │
    ├── Project A
    ├── Project B
    ├── Project C
    └── Project N
```

Each project instance inherits:

* Lifecycle
* Documentation structure
* Templates
* Naming conventions
* Decision-making mechanisms
* Quality gates
* Project management conventions

The project instance then provides:

* Project-specific requirements
* Decisions
* Architecture
* Implementation
* Documentation
* Metrics
* Release information


# 9. Recommended Repository Structure

The blueprint repository itself should be separated from individual project instances.

```text
software-project-blueprint/
│
├── README.md
├── blueprint.md
│
├── principles/
│
├── lifecycle/
│   ├── 01-vision/
│   ├── 02-terminology/
│   ├── 03-discovery/
│   ├── 04-requirements/
│   ├── 05-specification/
│   ├── 06-design/
│   ├── 07-architecture/
│   ├── 08-development/
│   ├── 09-validation/
│   ├── 10-release/
│   └── 11-operation/
│
│
├── templates/
│   ├── vision.md
│   ├── requirements.md
│   ├── risk.md
│   ├── adr.md
│   ├── poc.md
│   ├── feature.md
│   ├── milestone.md
│   └── release.md
│
├── standards/
│   ├── documentation.md
│   ├── naming.md
│   ├── decisions.md
│   └── quality.md
│
└── examples/
```


# 10. Project Instance Structure

A project generated from the blueprint may use the following structure:

```text
my-project/
│
├── README.md
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
└── 11-operation/
```

The exact structure may be adapted depending on project complexity.


# 11. Quality Gates


A **Quality Gate** is a [constraint][rm constraint whatis] used to determine whether the project can progress through the [lifecycle][lfc whatis].

Each major phase should have an explicit **quality gate**.

A quality gate provides a formal, measurable indication that the project is ready to progress. It answers:

> "Do we have enough evidence to proceed?"

Example:

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

Quality gates should not exist merely as administrative checkpoints. Their purpose is to prevent the project from progressing while critical uncertainties remain unresolved.


# 12. Project Status

A project should expose its current lifecycle state clearly.

Example:

```text
STATUS: MVP
VERSION: 0.3
HEALTH: ON_TRACK
```

Possible lifecycle states:

```text
IDEA
VISION
DISCOVERY
SPECIFICATION
POC
ARCHITECTURE
MVP
DEVELOPMENT
VALIDATION
RELEASE
OPERATION
ARCHIVED
```

Project health and lifecycle state should remain separate concepts.

For example:

```text
STATUS: DEVELOPMENT
HEALTH: AT_RISK
```


# 13. Documentation Principles

All project documentation should be:

* Version controlled
* Written in Markdown
* Structured consistently
* Easy to navigate
* Traceable to project decisions
* Updated as the project evolves

The documentation repository should serve as the project's **single source of truth**.


# 14. Project Rendering & Publication

The blueprint and project instances are authored as Markdown and rendered using **Algernon**.

The documentation system should provide:

* Navigation between lifecycle phases
* Cross-references between documents
* Searchability
* Consistent rendering
* Git-based version history
* Publication through GitHub

The rendering layer should remain separate from the project management model.

In other words:

```text
PROJECT KNOWLEDGE
       │
       ▼
   MARKDOWN
       │
       ▼
    ALGERNON
       │
       ▼
 DOCUMENTATION
```



# 15. Definition of Done

The blueprint itself is considered operational when:

* A new project can be instantiated from it.
* The lifecycle is clearly defined.
* Each phase has an objective.
* Each phase has expected inputs, outputs and outcomes.
* Templates exist for recurring artifacts.
* Quality gates are defined.
* Project status can be determined consistently.
* Documentation can be rendered through Algernon.
* A developer can understand how to use the blueprint without requiring additional instructions.


# 16. Guiding Principle

The blueprint should ultimately answer four questions at every stage of a project:

> **Why are we building this?**
> **What are we building?**
> **How are we going to build it?**
> **How do we know it works?**

The lifecycle provides the progression:

```text
VISION
   │
   ▼
TERMINOLOGY
   │
   ▼
DISCOVERY
   │
   ▼
REQUIREMENTS
   │
   ▼
SPECIFICATION
   │
   ▼
DESIGN
   │
   ▼
ARCHITECTURE
   │
   ├── PoC milestone
   │
   ▼
DEVELOPMENT
   │
   ├── MVP milestone
   │
   ▼
VALIDATION
   │
   ▼
RELEASE
   │
   ▼
OPERATE & EVOLVE
```



# the repository structure

We can structure it around three layers:

```text
BLUEPRINT
├── Framework
│   ├── lifecycle
│   ├── principles
│   └── standards
│
├── Templates
│   ├── vision
│   ├── requirements
│   ├── poc
│   ├── architecture
│   ├── mvp
│   ├── feature
│   ├── adr
│   └── release
│
└── Project Instance
    └── generated from the blueprint
```
