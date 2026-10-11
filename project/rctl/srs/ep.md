[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../ep.md

[↖ Project Blue][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[vision howto]:      ../whatis/ep.md#core-vision
[terminology howto]: ../whatis/ep.md#phase-02---terminology-and-concepts

Related topics

| Topic | Location| Kind |
|-|-|-|
|[How-to for CLI][cli howto]|
|[What is a Repository][repo whatis]|


---

[cli howto]: ../howto/cli-grammar.md
[REQ-01]: ../../spec/REQ-01-requirements.md
[SPEC-01]: ../../spec/SPEC-01-architecture.md
[ADR-02]: ../../adr/ADR-02-decoupled-output-formatting.md

**Document's status**
- Early development.
- The project is currently defining its core concepts and architecture.


<h1 align="center">Project: RCtl — SRS</h1>

# Requirements Register

|Key|value|
|-|-|
|Project|RCtl
|version|v0.1
|Vision|[vision][vision whatis]
|Terminology|[terminology][terminology whatis]
|Last updated|<2026-10-11>

**Terminology**
- T&C = Terminology & Concepts

**Group**

| # |Group | Theme | Covers |
| -| ----- | ----- | ------ |
| GRP-01 | |Model       | deal with model |  |
| GRP-02 | Capabilities | What the system does | provision, operate, adopt, compose |
| GRP-03 | Independence | What the system abstracts away | target, mechanism, kind, granularity |

**Legend**

|attribute|possible values|
|-|-|
|Status|draft · proposed · agreed · implemented · verified · rejected · obsolete
|Kind|functional · non-functional
|Priority|must · should · could · won't (MoSCoW)
|Statement form|every `Statement` reads as *"The system shall …"* — the prefix is implicit and omitted from the cells.
|Group|Model · Capabilities · Independence

> ⚠️ = depends on an open terminology point


## Register

| ID | Group | Version | Status | Kind | Priority | Title | Statement | Source | Rationale |
| -- | ----- | ------- | ------ | ---- | -------- | ----- | --------- | ------ | --------- |
| REQ-001 | Model | 0.1 | draft | functional | must | Resource model | represent resources through a resource model. | Vision §Core vision; T&C §Model, §Resource | Resources need their own representation. |
| REQ-002 | Model | 0.1 | draft | functional | must | Target model | represent targets through a target model. | Vision §Core vision; T&C §Model, §Target | Targets need their own representation. |
| REQ-003 | Model | 0.1 | draft | functional | must | Distinct models | keep the resource model and the target model distinct. | T&C §Model, §Resource, §Target (your correction) | A resource is not a target; conflating them breaks the model. |
| REQ-004 | Model | 0.1 | draft | functional | must | Model relationships | represent relationships between resources and targets in the common model. | Vision §Core vision; T&C §Model | Relationships are part of the model. |
| REQ-005 | Capabilities | 0.1 | draft | functional | must | Provision | provision resources. | Vision §Core vision; T&C §Provisioning | Core capability. |
| REQ-006 | Capabilities | 0.1 | draft | functional | must | Operate | operate resources. | Vision §Core vision; T&C §Operation | Core capability. |
| REQ-007 | Capabilities | 0.1 | draft | functional | must | Expose existing resources | expose a pre-existing resource within its model. | Vision §Strategy; T&C §Expose/Adopt/Import | Strategy: expose/adopt. |
| REQ-008 | Capabilities | 0.1 | draft | functional | must | Adopt existing resources | adopt a pre-existing resource so it becomes manageable as if the system had created it. | Vision §Strategy; T&C §Expose/Adopt/Import | First-class citizen. |
| REQ-009 | Capabilities | 0.1 | draft | functional | must | Compose into workflows | compose resources, tools, and capabilities into complete workflows. | Vision §Strategy; T&C §Composing | The system is the glue. |
| REQ-010 | Capabilities | 0.1 | draft | non-functional | must | Rely on existing tooling | rely on existing tools, platforms, and APIs as building blocks rather than reimplementing them. | Vision §Strategy | Don't reinvent specialized tooling. |
| REQ-011 | Capabilities | 0.1 | draft | non-functional | must | Unifying layer, not replacement | serve as a unifying layer over external tooling rather than a replacement for it. | Vision §Strategy | Layer, not replacement. |
| REQ-012 | Independence | 0.1 | draft | functional | must | Provision regardless of target | provision a resource regardless of the target where it resides. | Vision §Target Outcome; T&C §Target | Target independence. |
| REQ-013 | Independence | 0.1 | draft | functional | must | Operate regardless of target | operate a resource regardless of the target where it resides. | Vision §Target Outcome; T&C §Target | Target independence. |
| REQ-014 | Independence | 0.1 | draft | functional | must | Provision regardless of mechanism | provision a resource regardless of the mechanism used to manage it. | Vision §Target Outcome; T&C §Mechanism | Mechanism independence. |
| REQ-015 | Independence | 0.1 | draft | functional | must | Operate regardless of mechanism | operate a resource regardless of the mechanism used to manage it. | Vision §Target Outcome; T&C §Mechanism | Mechanism independence. |
| REQ-016 | Independence | 0.1 | draft | functional | must | Kind coverage | support resources of different kinds. | Vision §Problem; T&C §Resource, §Kind | Kind varies. |
| REQ-017 | Independence | 0.1 | draft | functional | must | Granularity coverage | support resources at different granularities, from atomic to composite. | Vision §Problem; T&C §Granularity | Granularity varies. |

## What changed vs v0.4

| Before | After |
| ------ | ----- |
| REQ-001 "Single model" — *represent resources through a single common model* | REQ-001 "Resource model" — *represent resources through a resource model* |
| REQ-002 "Model targets" — *represent targets in the common model* | REQ-002 "Target model" — *represent targets through a target model* |
| — | **REQ-003 "Distinct models"** — *keep the resource model and the target model distinct* (new) |
| REQ-003 "Model relationships" | REQ-004 (renumbered) |
| REQ-004…016 | shifted +1 → REQ-005…017 |

## Consequence for Phase 02

This correction ripples back into T&C §Model, which currently says:

> *"The abstract schema or declarative structure used to represent resources, targets, and their relationships uniformly."*

That phrasing implies **one** model covering both. Your correction says **two** models, kept distinct. Proposed rewrite of §Model:

> **Model**
> The abstract schema or declarative structure used to represent **resources** and **targets** uniformly.
> - Two **distinct** models: a **resource model** and a **target model**.
> - They may share a common vocabulary, but a resource is not a target and must not be conflated with one.
> - **Answers**: *How are things represented in a common way?*
> - **Contrast**: The models are the *representation*. **Mechanisms** and **Targets** are the *reality* they describe.

## Open points (not rows)

- ⚠️ **Operating** — no dedicated T&C entry.
- ⚠️ **Workflow** — used but undefined.
- ⚠️ **Building block** — used but undefined.
- ⚠️ **Lifecycle phase vs workflow stage** — deferred.
- **Target** — remove *"cloud region"* / *"multi-cloud setup"* from examples.
- **Provision vs Operation** — provision is more generic; reflect in T&C.
- **Operation = exposed resource capability** — reflect in T&C §Operation.
- **Resource model ≠ target model** — reflect in T&C §Model (new).

## Question

REQ-004 "Model relationships" still says *"in the common model"* — but we just removed "common model" as a concept. Should it become:

- **(A)** *"represent relationships between resources and targets in the models."* (plural), or
- **(B)** *"represent relationships between a resource and its target."* (only the resource↔target relation), or
- **(C)** *"represent relationships between resources, and between resources and targets."* (both kinds)?

Which one reflects your intent?