[//]: #(home)
[home set]: ../../README.md
[home doc]: ../../../README.md

[↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[requirement howto]: ../howto/ep.md

Related topics

| Topic                                          | Location | Kind |
| ---------------------------------------------- | -------- | ---- |
|[How-to for Requiremnt][requirement howto]

<h1 align="center">What is a Software Requirement</h1>

The concept of Software Requirement

# Definition




## Requirement
- Describes what a **system** (ie. the software) must satisfy to be considered **acceptable** by its **stakeholders**
- Based on a need, expectation, obligation or constraint (e.g. extracted from the software project vision).

**What it is not**
- A desire or a wish. 
- A wish can **become a requirement** once it is agreed upon, documented, and treated as binding for the project.

## Specification
- A **formal** description of one or more requirements.

## SRS
- a document
- List specifications

# Kind

**Nature**:
- Functional
- Non-Functional
    - Technical
    - Performance
    - Security
    - Usability
    - ..


**Object**:
- a capability
- a characteristic
- a constraint (design, ...)


# Criteria for a requirement

- **Atomic** — it states a single **object**. If two claims can be verified independently, they are two requirements.
- **Necessary** — its absence would make the system incomplete or unfit for purpose.
- **Verifiable** — it can be checked, tested, or otherwise confirmed once implemented.
- **Unambiguous** — it has only one reasonable interpretation.
- **Traceable** — it can be linked back to a source (a stakeholder need, a regulation, a business goal).

# Requirement lifecycle
Typical stages of a requirement's lifecycle:

| Stage | What happens |
| ----- | ------------ |
| **Elicitation** | The requirement is discovered / captured from a source (stakeholder, regulation, vision, existing system, ...). |
| **Analysis** | It is refined, checked for conflicts, feasibility, priority, and dependencies. |
| **Specification** | It is written down formally (becomes a specification, enters the SRS). |
| **Validation** | It is confirmed that it is the *right* requirement (agreed by stakeholders, meets criteria: necessary, verifiable, unambiguous, traceable). |
| **Implementation** | It is realized in the software (linked to design, code, tests). |
| **Verification** | It is confirmed that the software *matches* the requirement (tested). |
| **Management / Change** | It is versioned, traced, modified, or deprecated as needs evolve. |
| **Retirement** | It is removed (no longer needed, obsolete, replaced). |

Key distinction to keep in mind:

- **Validation** = "Did we write the *right* requirement?"
- **Verification** = "Did we build the requirement *right*?"

# Requirement Attributes

A minimal list of attributes a requirement should have

| Attribute | Meaning | Example |
| --------- | ------- | ------- |
| **Title** | Short human label — much easier to scan than a full sentence. |
| **ID** | Stable unique identifier. Never reused, never renumbered. | `REQ-001` |
| **Version** | Revision of *this* requirement's text. | `0.1`, `1.0` |
| **Statement** | The requirement itself ("The system shall …"). |
| **Status** | Where it is in its lifecycle. | `draft`, `proposed`, `agreed`, `implemented`, `verified`, `rejected`, `obsolete` |
| **Kind** | Functional / Non-functional (matches your doc). |
| **Priority** | MoSCoW (`must`/`should`/`could`/`won't`) or 1–5. |
| **Source** | Where it came from (traceability). | `vision §3.2`, `stakeholder: CTO`, `law: GDPR art.5` |
| **Owner** | Who is accountable for it. |
| **Created / Updated** | Dates. |
| **Rationale** | *Why* it exists. The need behind it. | "Users must log in to protect personal data." |
| **Links** | Parent requirement, related requirements, tests. |


# The process
| # | Artifact | Question it answers | Why next |
| - | -------- | ------------------- | -------- |
| 1 | **Use cases / scenarios** | *Who does what, end to end?* | Turns abstract REQs into concrete stories. E.g. "Adopt an existing AWS RDS database." |
| 2 | **Acceptance criteria** | *How do we know a REQ is satisfied?* | One per REQ. Makes `draft` → `agreed` possible. |
| 3 | **Concrete examples per REQ** | *Show me one instance.* | "Provision a Kubernetes cluster on OVH from a manifest." |
| 4 | **Design** | *How will it work?* | Model schema, mechanism adapters, operation API. |
| 5 | **Traceability matrix** | *Which REQ does this design/test cover?* | Keeps design honest. |
| 6 | **Reverse-engineer Phase 01 & 02** | *Are the terms still true?* | Your earlier plan. Confirms vision ↔ terms ↔ REQs align. |


# Terminology
|Term|Meaning|Notes|
|-|-|-|
|SRS|**S**oftware **R**equirements **S**pecification| a document

# Relationships

|subject|Relation|object|
|-|-|-|
|Specification|describes|one or more requirements|
|Requirement|is specified/formalized in|one specification|
|Requirement|can be documented in|one SRS|

# Todo
**Reference**
- *software engineering* terminology (e.g., IEEE 610.12, ISO/IEC 25010)
- standards (IEEE, ISO)