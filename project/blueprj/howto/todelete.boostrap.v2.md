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

<h1 align="center">Project: Blue</h1>

a Software Project Management Blueprint

# Bootstrap a Software Project

This tutorial explains how to create a new software project from the **Software Project Blueprint**.

## 1. Prerequisites

Before starting, you need:

| Input                          | Mandatory | Default | Description                                                                  |
| ------------------------------ | --------- | ------- | ---------------------------------------------------------------------------- |
| **Software Project Blueprint** | ✓         | —       | The blueprint used to instantiate the project                                |
| **Project code name**          | ✓         | —       | A short identifier used consistently across the project                      |
| **Idea**                       | ✓         | —       | A problem worth solving, or a value worth producing                          |
| **Stakeholders**               | ✓         | —       | People or organizations interested in the project or its result              |
| **Constraints**                | ✗         | none    | Known limits such as budget, deadline, team size, technology, or regulations |

The project code name should be used consistently across the project.


## 2. Create the Project Repository

Create a new repository for the project.

For example:

```bash
mkdir my-project
cd my-project
```

The repository is the root of the new project instance.

At this point, the repository contains no project-specific information.

## 3. Create the Project Entry Point

Create the project entry point:

```yaml
# entry point: <project-name>/whatis/ep.md
my-project/
└── whatis/
    └── ep.md
```

- Use it as the main navigation for the project.
- It should contains links to the project's authoritative documentation.

For example:

```text
whatis/ep.md
      │
      ├── vision
      ├── requirements
      ├── specification
      ├── design
      ├── architecture
      ├── development
      ├── validation
      └── releases
```

```markdown
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

## 4. Create the Project Structure

Create the structure defined by the blueprint.

For example:

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

Use the blueprint as the source for the required structure.

> ⚠️ Do not invent a different structure unless the project requires an explicit adaptation.

## 5. Initialize Project Information

Start with the information needed to define the project.

The first project artifacts normally describe:

* Vision
* Problem
* Goals
* Scope
* Success criteria

Create these from the corresponding blueprint templates.

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

## 6. Define Project Terminology

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

## 7. Perform Discovery

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

## 8. Define Requirements

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

## 9. Create the Specification

> 💡 Turn the requirements into a product specification.

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

## 10. Create the Design

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

## 11. Define the Architecture

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

## 12. Plan Development

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

## 13. Use PoCs When Needed

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

## 14. Define the MVP

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

## 15. Validate the Project

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

## 16. Prepare a Release

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

## 17. Operate and Evolve

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

## 18. Keep One Source of Truth

Throughout the project, maintain a single authoritative location for each important piece of information.

For example:

| Information             | Authoritative location          |
| ----------------------- | ------------------------------- |
| Project vision          | `01-vision/vision.md`           |
| Project scope           | `01-vision/scope.md`            |
| Requirements            | `04-requirements/`              |
| Product specification   | `05-specification/`             |
| Architecture            | `07-architecture/`              |
| Architectural decisions | `07-architecture/decisions/`    |
| Roadmap                 | `08-development/roadmap.md`     |
| Milestones              | `08-development/milestones.md`  |
| Validation results      | `09-validation/test-results.md` |
| Release information     | `10-release/`                   |

Other documents may reference this information.

They should not maintain independent copies of it.

The project entry point should link to the authoritative documents instead of duplicating their content.

## 19. Commit the Initial Project

Once the initial structure is ready, commit it to Git.

```bash
git add .
git commit -m "Bootstrap project"
```

The repository now contains the initial project instance.

From this point, project work proceeds through the lifecycle defined by the blueprint.

## 20. Project Bootstrap Result

A successfully bootstrapped project should have:

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

The project repository becomes the source of truth for the project's actual information.

## 21. Future Automation

The manual bootstrap process is not a requirement of the blueprint.

It is simply the current way to instantiate a project.

A future tool may automate the same process:

```text
Software Project Blueprint
          │
          ▼
   Project Generator
          │
          ▼
     my-project/
```

For example:

```bash
project create my-project
```

The generated project should follow the same blueprint.

Automation changes **how the project is created**, not **what the project model is**.

This keeps the blueprint independent from the tooling used to instantiate it.
