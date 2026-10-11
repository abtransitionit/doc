[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../ep.md

[↖ Project Blue][home topic] · [↖ Concept][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[vision howto]:      ../whatis/ep.md#core-vision
[terminology howto]: ../whatis/ep.md#phase-02---terminology-and-concepts
[requirement list]:  ../srs/ep.md
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


<h1 align="center">Project: RCtl — USe Case</h1>

# Use case Register

|Key|value|
|-|-|
|version|v0.1
|Derived from|[Requirements Register][requirement list]
|Last updated|<2026-10-11>

## Legend

|attribute|possible values|
|-|-|
| Actor| Operator (human) · Agent (automated) · Stakeholder (reviews/agrees)
| Status| draft · proposed · agreed · rejected
| Covers| the REQ IDs this use case exercises

<a id="index"></a>
## [Index](#index)

- [UC-01 — Provision a new resource](#uc-01)
- [UC-02 — Adopt an existing resource](#uc-02)
- [UC-03 — Operate a resource across targets](#uc-03)
- [UC-04 — Provision the same resource on two targets](#uc-04)
- [UC-05 — Compose a deployment workflow](#uc-05)
- [UC-06 — Use different mechanisms for the same operation](#uc-06)
- [UC-07 — Reset a resource](#uc-07)
- [UC-08 — Inspect the model](#uc-08)
- [Coverage check](#coverage-check)
- [Candidate gaps](#candidate-gaps)

---

<a id="uc-01"></a>
# [UC-01](#uc-01) — Provision a new resource
[↑ Index](#index)

- **Actor**: Operator
- **Goal**: Get a resource created and ready for use.
- **Covers**: REQ-001, REQ-002, REQ-004, REQ-011, REQ-013
- **Status**: draft

## Main flow

1. Operator declares the resource and its target.
2. System records the declaration in the resource model (REQ-001) and target model (REQ-002).
3. System selects a mechanism appropriate to the target and resource.
4. System provisions the resource (REQ-004).
5. Operator checks status.

## Notes

- Provisioning works regardless of the target (REQ-011).
- Provisioning works regardless of the mechanism (REQ-013).

---

<a id="uc-02"></a>
# [UC-02](#uc-02) — Adopt an existing resource

[↑ Index](#index)

- **Actor**: Operator
- **Goal**: Bring a pre-existing resource under the system's control.
- **Covers**: REQ-001, REQ-002, REQ-003, REQ-005, REQ-006, REQ-007
- **Status**: draft

## Main flow

1. Operator declares an existing resource (e.g. an AWS RDS database).
2. System exposes it (REQ-006).
3. System adopts it into the resource model (REQ-007, REQ-001).
4. System associates it with its target (REQ-002, REQ-003).
5. Operator inspects it like a native resource (REQ-005).

## Notes

- After adoption, the resource is a first-class citizen: indistinguishable from one the system created.

---

<a id="uc-03"></a>
# [UC-03](#uc-03) — Operate a resource across targets

[↑ Index](#index)

- **Actor**: Operator
- **Goal**: Act on a resource regardless of where it lives.
- **Covers**: REQ-005, REQ-012, REQ-014
- **Status**: draft

## Main flow

1. Operator selects a resource.
2. System resolves its target.
3. Operator runs an operation (e.g. `get-status`).
4. The same command works whether the target is local, remote, or cloud.

## Notes

- Operation works regardless of the target (REQ-012).
- Operation works regardless of the mechanism (REQ-014).

---

<a id="uc-04"></a>
# [UC-04](#uc-04) — Provision the same resource on two targets

[↑ Index](#index)

- **Actor**: Operator
- **Goal**: Prove target independence for provisioning.
- **Covers**: REQ-001, REQ-004, REQ-011, REQ-015, REQ-016
- **Status**: draft

## Main flow

1. Operator declares a resource kind (e.g. Kubernetes cluster).
2. Provisions it on OVH.
3. Provisions the same kind on bare metal.
4. Both are represented identically in the resource model.

## Notes

- Same kind, different targets (REQ-011).
- Supports resources of different kinds (REQ-015) and granularities (REQ-016).

---

<a id="uc-05"></a>
# [UC-05](#uc-05) — Compose a deployment workflow

[↑ Index](#index)

- **Actor**: Operator
- **Goal**: Chain several resources, tools, and operations into one workflow.
- **Covers**: REQ-008, REQ-009, REQ-010, REQ-013, REQ-014
- **Status**: draft

## Main flow

1. Operator defines a workflow: DB + repo + migration + manifests + CI.
2. System runs each step via its mechanism.
3. Operator monitors the whole workflow.

## Notes

- The system composes resources, tools, and capabilities (REQ-008).
- It relies on existing tooling (REQ-009) as a unifying layer (REQ-010).
- Each step is provisioned or operated regardless of mechanism (REQ-013, REQ-014).

---

<a id="uc-06"></a>
# [UC-06](#uc-06) — Use different mechanisms for the same operation

[↑ Index](#index)

- **Actor**: Operator
- **Goal**: Prove mechanism independence.
- **Covers**: REQ-005, REQ-013, REQ-014
- **Status**: draft

## Main flow

1. Operator provisions a repo via `gh`.
2. Provisions another via the GitHub API.
3. Both are modeled identically.

## Notes

- Same operation, different mechanisms.

---

<a id="uc-07"></a>
# [UC-07](#uc-07) — Reset a resource

[↑ Index](#index)

- **Actor**: Operator
- **Goal**: Return a resource to a known state.
- **Covers**: REQ-005, REQ-012, REQ-014
- **Status**: draft

## Main flow

1. Operator selects a repo.
2. Runs `reset-history`.
3. System executes via the right mechanism on the right target.

## Notes

- Works regardless of target (REQ-012) and mechanism (REQ-014).

---

<a id="uc-08"></a>
# [UC-08](#uc-08) — Inspect the model

[↑ Index](#index)

- **Actor**: Operator, Agent
- **Goal**: See what the system knows.
- **Covers**: REQ-001, REQ-002, REQ-003, REQ-015, REQ-016
- **Status**: draft

## Main flow

1. Operator lists all resources.
2. Filters by target, kind, granularity.
3. Sees relationships between resources and targets.

## Notes

- The resource model (REQ-001), target model (REQ-002), and their relationships (REQ-003) are all queryable.
- Filtering exercises kind coverage (REQ-015) and granularity coverage (REQ-016).

---

<a id="coverage-check"></a>
# [Coverage check](#coverage-check)

[↑ Index](#index)

| REQ | Covered by |
| --- | ---------- |
| REQ-001 Resource model | UC-01, 02, 04, 08 |
| REQ-002 Target model | UC-01, 02, 08 |
| REQ-003 Model relationships | UC-02, 08 |
| REQ-004 Provision | UC-01, 04 |
| REQ-005 Operate | UC-02, 03, 06, 07 |
| REQ-006 Expose | UC-02 |
| REQ-007 Adopt | UC-02 |
| REQ-008 Compose | UC-05 |
| REQ-009 Rely on tooling | UC-05 |
| REQ-010 Unifying layer | UC-05 |
| REQ-011 Provision regardless of target | UC-01, 04 |
| REQ-012 Operate regardless of target | UC-03, 07 |
| REQ-013 Provision regardless of mechanism | UC-01, 05, 06 |
| REQ-014 Operate regardless of mechanism | UC-03, 05, 06, 07 |
| REQ-015 Kind coverage | UC-04, 08 |
| REQ-016 Granularity coverage | UC-04, 08 |

**All 16 REQs are covered.**

---

<a id="candidate-gaps"></a>
# [Candidate gaps](#candidate-gaps)

[↑ Index](#index)

From writing these use cases:

1. **No use case for `destroy`** — the vision mentions destroy/rehydrate. No REQ covers it.
2. **No use case for target-level reset** — only repo history (UC-07).
3. **No use case for parallel tasks / stage ordering** — dropped as design; confirm out of scope.
4. **No use case for Agent API** — UC-08 hints at an agent actor. Worth its own REQ if in scope.
5. **No use case for failure** — what happens when a mechanism fails?
