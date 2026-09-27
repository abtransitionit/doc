[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../howto/boostrap.md

[↖ Bootstrap][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[lfc whatis]: /concept/lifecycle/whatis/ep.md
[poc whatis]: /concept/test/whatis/poc.md
[mvp whatis]: /concept/test/whatis/mvp.md
[rm constraint whatis]: /concept/roadmap/whatis/constraint.md
[prj whatis]: ../whatis/ep.md
[bootstrap 01 howto]:    ../howto/bootstarp-01.md
[bootstrap 02 howto]:    ../howto/bootstrap-02.md

Related topics

| Topic                            | Location | Kind |
| -------------------------------- | -------- | ---- |
| [What is a software project][prj whatis] | internal |      |

<h1 align="center">Project: Blue</h1>

a Software Project Management Blueprint

# Bootstrap a Software Project

This tutorial describes how to manually instanciate the **blueprint** to create a **Software Project** with the following

* **Storage:** file system
* **Representation:** one Markdown file for the project


## 2. Prerequisites

Before starting, you need:

| Input                          | Mandatory | Default | Description                                                                  |
| ------------------------------ | --------- | ------- | ---------------------------------------------------------------------------- |
| **Software Project Blueprint** | ✓         | —       | The blueprint used to instantiate the project                                |
| **Project code name**          | ✓         | —       | A short identifier used consistently across the project                      |
| **Idea**                       | ✓         | —       | A problem worth solving, or a value worth producing                          |
| **Stakeholders**               | ✓         | —       | People or organizations interested in the project or its result              |
| **Constraints**                | ✗         | none    | Known limits such as budget, deadline, team size, technology, or regulations |

The project code name should be used consistently throughout the project.

## 3. Create the Project Repository

Create a new repository for the project.

For example:

```bash
mkdir my-project
cd my-project
```

The repository is the root storage location for this project instance.

At this point, the repository contains no project-specific information.

## 4. Create the Project Entry Point

For this instantiation use case, the project itself is represented by **one Markdown document**.

Create:

```text
my-project/
└── project.md
```

The document is the main and authoritative representation of the project.

It should contain the project information defined by the blueprint.

Unlike the folder-based instantiation, no lifecycle folder structure is required.

The lifecycle remains a **logical structure** of the project.

It is represented inside the Markdown document rather than by physical folders.

For example:

```text
project.md

# Project

## 01 Vision

## 02 Terminology

## 03 Discovery

## 04 Requirements

## 05 Specification

## 06 Design

## 07 Architecture

## 08 Development

## 09 Validation

## 10 Release

## 11 Operate & Evolve
```

> 🚀 **Note:** The Markdown headings are a physical representation of the logical lifecycle stages.

The document should contain the project's actual information.

It should not contain a copy of the blueprint itself.

## 5. Create the Project Structure

**Create the representation** of the lifecycle defined by the blueprint.

For this instantiation use case: **one Markdown file**.

```text
my-project/
└── project.md
```

The logical project structure remains:

```text
Project
│
├── Vision
├── Terminology
├── Discovery
├── Requirements
├── Specification
├── Design
├── Architecture
├── Development
├── Validation
├── Release
└── Operate & Evolve
```

The difference is only in how this logical structure is represented.

In [boot][bootstrap 01 howto], each lifecycle phase is represented by a folder.

In [boot][bootstrap 02 howto], each lifecycle phase is represented by a section in the same Markdown document.

> 🚀 **Note:** The representation changes. The project model does not.

## 6. Initialize Project Information

Start with the information needed to define the project.

The project normally describes:

* Vision
* Problem
* Goals
* Scope
* Success criteria

For example:

```text
project.md

# Project: My Project

## 01 Vision

### Vision

### Problem

### Goals

### Scope

### Success Criteria
```

At this stage, write information specific to the project.

> ⚠️ Do not copy example content from the blueprint as project content.

## 7. Define Project Terminology

Create the terminology used by the project.

For example:

```text
project.md

## 02 Terminology

### Glossary

### Concepts
```

Define important project-specific terms.

When a concept has a dedicated authoritative section, reference that section rather than duplicating its definition.

> 💡 This helps use the terminology consistently throughout the project.

## 8. Perform Discovery

Populate the discovery information defined by the blueprint.

For example:

```text
project.md

## 03 Discovery

### Domain

### Users

### Requirements

### Assumptions

### Constraints

### Risks
```

Capture what is known about the problem and its context.

Record assumptions and uncertainties explicitly.

> ⚠️ Do not treat assumptions as facts.

## 9. Define Requirements

Create the project requirements.

For example:

```text
project.md

## 04 Requirements

### Functional Requirements

### Non-Functional Requirements

### Business Rules

### Acceptance Criteria
```

Requirements should describe what the project must achieve.

> 💡 Keep requirements separate from implementation details.

When a requirement changes, update its authoritative section.

> ⚠️ Do not maintain separate copies of the same requirement in multiple sections.

## 10. Create the Specification

Turn the requirements into a product specification.

For example:

```text
project.md

## 05 Specification

### Product

### Features

### Use Cases

### Workflows

### Requirements Traceability
```

The specification should make the intended product behavior concrete enough to guide design and implementation.

Trace the specification back to the relevant requirements.

## 11. Create the Design

Define the product and technical design.

For example:

```text
project.md

## 06 Design

### Product

### Workflows

### Interfaces

### Technical Design
```

Describe how the specified product should behave and interact.

Keep implementation decisions that affect the architecture in the architecture section.

## 12. Define the Architecture

Create the architecture documentation.

For example:

```text
project.md

## 07 Architecture

### Overview

### Components

### Principles

### Data

### Integrations

### Security

### Decisions

#### ADR-001 Database

#### ADR-002 Authentication
```

Create an ADR for significant architectural or technical decisions.

The ADR section is the authoritative record of the decision.

Other sections may reference it.

> ⚠️ Do not record the same decision independently in several sections.

## 13. Plan Development

Create the development planning structure.

For example:

```text
project.md

## 08 Development

### Roadmap

### Milestones

### Backlog

### Iterations

### Releases
```

Define the project's roadmap and milestones.

Break the work into increments that can be built and validated.

A milestone may represent a PoC, MVP, release, or another meaningful project objective.

## 14. Use PoCs When Needed

When an important uncertainty needs to be validated, create a PoC.

The PoC should answer a specific question.

For example:

* Is the proposed workflow useful?
* Is the technical approach viable?
* Can an integration work as required?
* Is an important assumption valid?

For this instantiation, the PoC can be represented as a section of the same Markdown document.

For example:

```text
project.md

## 08 Development

### PoCs

#### PoC-001

##### Objective

##### Scope

##### Features

##### Implementation

##### Target Delta

##### Results

##### Conclusion
```

Keep the PoC smaller than the target implementation when possible.

The PoC does not need to use the final technology or architecture.

Record the result and what it changes in the project.

If the PoC changes requirements, scope, architecture, or the roadmap, update the authoritative sections of the project document.

## 15. Define the MVP

When enough uncertainty has been reduced, define the MVP.

The MVP should describe the minimum implementation required to validate the intended product.

For example:

```text
project.md

## 08 Development

### MVP

#### Definition

#### Scope

#### Features

#### Implementation

#### Acceptance Criteria

#### Success Metrics
```

The MVP should incorporate relevant findings from PoCs and earlier validation.

Do not create a second, conflicting definition of the MVP elsewhere in the document.

## 16. Validate the Project

Create the validation information.

For example:

```text
project.md

## 09 Validation

### Test Plan

### Test Results

### Acceptance
```

Validate the implementation against the defined requirements and acceptance criteria.

Record the results.

If validation exposes a problem, update the appropriate authoritative section rather than hiding the change in test documentation.

## 17. Prepare a Release

When an increment is ready for release, prepare the release information.

For example:

```text
project.md

## 10 Release

### Readiness

### Checklist

### Deployment

### Rollback

### Release Notes
```

Verify the applicable release conditions.

The release process should cover the relevant areas defined by the blueprint, including:

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

## 18. Operate and Evolve

After release, continue maintaining the project.

For example:

```text
project.md

## 11 Operate & Evolve

### Monitoring

### Incidents

### Metrics

### Improvements
```

Use operational information and user feedback to identify improvements.

Feed validated changes back into the appropriate project sections.

The project therefore continues through cycles of:

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

## 19. Keep One Source of Truth

Throughout the project, maintain a single authoritative location for each important piece of information.

In this instantiation, the project document is that location.

Other files may exist for supporting material when necessary, but they should not become independent copies of project information.

The project therefore has:

```text
one project
    │
    └── one authoritative Markdown document
             │
             ├── Vision
             ├── Terminology
             ├── Discovery
             ├── Requirements
             ├── Specification
             ├── Design
             ├── Architecture
             ├── Development
             ├── Validation
             ├── Release
             └── Operate & Evolve
```

> ⚠️ The single-file representation does not remove the logical separation between lifecycle stages.

## 20. Commit the Initial Project

Once the initial document is ready, commit it to Git.

```bash
git add .
git commit -m "Bootstrap project"
```

The repository now contains the initial representation of the project instance.

From this point, project work proceeds through the lifecycle defined by the blueprint.

## 21. Project Bootstrap Result

A project instantiated using this use case should have a structure such as:

```text
my-project/
└── project.md
```

The project document contains the logical lifecycle:

```text
project.md

# Project

## 01 Vision
## 02 Terminology
## 03 Discovery
## 04 Requirements
## 05 Specification
## 06 Design
## 07 Architecture
## 08 Development
## 09 Validation
## 10 Release
## 11 Operate & Evolve
```

The project is now an **instance of the Software Project Blueprint**.

The blueprint remains the source of the project model.

The instantiated project contains the project's actual information.

The difference from [kind 01] is the physical representation:

|                          | [kind 01]             | [kind 02]                  |
| ------------------------ | --------------------- | -------------------------- |
| Storage                  | file system           | file system                |
| Folder                   | 1 per lifecycle phase | 1 project folder           |
| Representation           | Markdown              | Markdown                   |
| Artifact representation  | one file per artifact | one document with sections |
| Lifecycle representation | folders + files       | headings + sections        |
| Entry point              | `whatis/ep.md`        | `project.md`               |
| Source of truth          | project artifacts     | `project.md`               |

## 22. Future Instantiation Methods

This use case is not a requirement of the blueprint.

Other instantiation methods may use a different representation or storage mechanism.

For example:

```text
Software Project Blueprint

      │

      ▼

Instantiation Method

      │

 ┌────┼────┬────┐

 ▼    ▼    ▼    ▼

Use 01  Use 02  Use 03  Use 04
```

The instantiation method changes **how the project model is represented and stored**, not **what the project model is**.

This keeps the separation between:

```text
Software Project Blueprint
        │
        ├── Instantiation Method 01
        │       └── Project Instance
        │
        ├── Instantiation Method 02
        │       └── Project Instance
        │
        └── ...
```

The next instantiation method can therefore introduce another representation without changing the underlying Software Project Blueprint.

