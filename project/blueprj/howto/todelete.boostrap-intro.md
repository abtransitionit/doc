[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Project Blue][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

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

This tutorial describes one possible way to instantiate the **Software Project Blueprint**.

The blueprint defines the logical project model.

Instantiation determines how that model is represented, stored, and accessed in a concrete project.

## 1. Instantiation Use Cases

The same project model can be instantiated using different representations and storage structures.

### Use Case 01 — One Folder, One File per Artifact

* **Storage:** file system
* **Representation:** one Markdown file per artifact
* **Folder:** one

### Use Case 02 — One File for All Artifacts

* **Storage:** file system
* **Representation:** one Markdown file for all artifacts

### Use Case 03 — One Folder per Stage

* **Storage:** file system
* **Representation:** one Markdown file per artifact
* **Folder:** one folder per lifecycle stage

These are different instantiation approaches for the same logical project model.

This tutorial describes **Use Case 03**.

---

## 2. Prerequisites

Before starting, you need:

| Input                          | Mandatory | Default | Description                                                                  |
| ------------------------------ | --------- | ------- | ---------------------------------------------------------------------------- |
| **Software Project Blueprint** | ✓         | —       | The blueprint used to instantiate the project                                |
| **Project code name**          | ✓         | —       | A short identifier used consistently across the project                      |
| **Idea**                       | ✓         | —       | A problem worth solving, or a value worth producing                          |
| **Stakeholders**               | ✓         | —       | People or organizations interested in the project or its result              |
| **Constraints**                | ✗         | none    | Known limits such as budget, deadline, team size, technology, or regulations |

The project code name should be used consistently across the project.

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

Create the project entry point.

For this instantiation use case, the entry point is stored as a Markdown document:

```text
my-project/
└── whatis/
    └── ep.md
```

Use it as the main navigation for the project.

It should contain links to the project's authoritative project information.

For example:

```text
whatis/ep.md
      │
      ├── vision
      ├── terminology
      ├── discovery
      ├── requirements
      ├── specification
      ├── design
      ├── architecture
      ├── development
      ├── validation
      ├── release
      └── operate & evolve
```

## 5. Create the Project Structure

Create the representation of the lifecycle defined by the blueprint.

For this instantiation use case:

```text
my-project/

├── whatis/
│   └── ep.md

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

The folders are a physical representation of the logical lifecycle stages.

## 6. Initialize Project Information

Start with the information needed to define the project.

The first project artifacts normally describe:

* Vision
* Problem
* Goals
* Scope
* Success criteria

For example:

```text
01-vision/

├── vision.md
├── problem.md
├── goals.md
├── scope.md
└── success-criteria.md
```

At this stage, write information specific to the project.

> ⚠️ Do not copy example content from the blueprint as project content.

## 7. Define Project Terminology

Create the terminology used by the project.

For example:

```text
02-terminology/

├── glossary.md
└── concepts/
```

Define important project-specific terms.

Use the terminology consistently throughout the project.

> ⚠️ When a concept has a dedicated authoritative document, reference that document rather than duplicating its definition.

## 8. Perform Discovery

Populate the discovery artifacts defined by the blueprint.

For example:

```text
03-discovery/

├── domain.md
├── users.md
├── requirements.md
├── assumptions.md
├── constraints.md
└── risks.md
```

Capture what is known about the problem and its context.

Record assumptions and uncertainties explicitly.

> ⚠️ Do not treat assumptions as facts.

## 9. Define Requirements

Create the project requirements.

For example:

```text
04-requirements/

├── functional.md
├── non-functional.md
├── business-rules.md
└── acceptance-criteria.md
```

Requirements should describe what the project must achieve.

> 💡 Keep requirements separate from implementation details.

> ⚠️ When a requirement changes, update its authoritative document.

> ⚠️ Do not maintain separate copies of the same requirement in multiple documents.

## 10. Create the Specification

Turn the requirements into a product specification.

For example:

```text
05-specification/

├── product.md
├── features.md
├── use-cases.md
├── workflows.md
└── requirements.md
```

The specification should make the intended product behavior concrete enough to guide design and implementation.

Trace the specification back to the relevant requirements.

## 11. Create the Design

Define the product and technical design.

For example:

```text
06-design/

├── product.md
├── workflows.md
├── interfaces.md
└── technical.md
```

Describe how the specified product should behave and interact.

Keep implementation decisions that affect the architecture in the architecture documentation.

## 12. Define the Architecture

Create the architecture documentation.

For example:

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

Create an ADR for significant architectural or technical decisions.

For example:

```text
07-architecture/

└── decisions/
    ├── ADR-001-database.md
    └── ADR-002-authentication.md
```

Do not record the same decision independently in several documents.

The ADR is the authoritative record of the decision.

Other documents may reference it.

## 13. Plan Development

Create the development planning structure.

For example:

```text
08-development/

├── roadmap.md
├── milestones.md
├── backlog.md
├── iterations/
└── releases/
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

Keep the PoC smaller than the target implementation when possible.

The PoC does not need to use the final technology or architecture.

Record the result and what it changes in the project.

If the PoC changes requirements, scope, architecture, or the roadmap, update the authoritative project documents.

## 15. Define the MVP

When enough uncertainty has been reduced, define the MVP.

The MVP should describe the minimum implementation required to validate the intended product.

For example:

```text
08-development/

└── mvp/
    ├── definition.md
    ├── scope.md
    ├── features.md
    ├── implementation.md
    ├── acceptance-criteria.md
    └── success-metrics.md
```

The MVP should incorporate relevant findings from PoCs and earlier validation.

Do not create a second, conflicting definition of the MVP elsewhere.

## 16. Validate the Project

Create the validation artifacts.

For example:

```text
09-validation/

├── test-plan.md
├── test-results.md
└── acceptance.md
```

Validate the implementation against the defined requirements and acceptance criteria.

Record the results.

If validation exposes a problem, update the appropriate authoritative project document rather than hiding the change in test documentation.

## 17. Prepare a Release

When an increment is ready for release, prepare the release artifacts.

For example:

```text
10-release/

├── readiness.md
├── checklist.md
├── deployment.md
├── rollback.md
└── release-notes.md
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
11-operate-evolve/

├── monitoring.md
├── incidents.md
├── metrics.md
└── improvements.md
```

Use operational information and user feedback to identify improvements.

Feed validated changes back into the appropriate project artifacts.

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

Other documents may reference this information.

They should not maintain independent copies of it.

The project entry point should link to the authoritative project information instead of duplicating its content.

## 20. Commit the Initial Project

Once the initial structure is ready, commit it to Git.

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

├── whatis/
│   └── ep.md

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

The project is now an **instance of the Software Project Blueprint**.

The blueprint remains the source of the project model.

The instantiated project contains the project's actual information.

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
     ┌────┼────┐
     ▼    ▼    ▼
   Use 01 Use 02 Use 03
```

The instantiation method changes **how the project model is represented and stored**, not **what the project model is**.

This gives us the correct separation. The next step can be to create the **single-file instantiation use case** as a separate tutorial, without mixing it with this one.
