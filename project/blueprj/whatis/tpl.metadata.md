[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep.md

[↖ Blue Project][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[semantic versioning whatis]: https://keepachangelog.com/en/1.1.0/

<div align="center">

# Project: Blue — Document Metadata Specification

A standardized metadata block specification and authoring template for project deliverables

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v1.0-blue)

</div>

| Field | Value |
| :--- | :--- |
| **Doc ID** | TPL-MTD-BLUE |
| **Project** | BLUE |
| **Path** | `tpl.metadata.md` |
| **Last Updated** | 2026-10-18 |

# 1. Overview

Every project document shall include **at least** theses standardized metadata to maintain auditability, traceability, and version control.

| Field | Kind | Value | Description / Permitted Options |
| :--- | :--- | :--- | :--- |
| **Doc Id** | Header | | Unique document identifier|
| **Path** | Header | `<filename.md>` | Relative file path in the repository (e.g., `docs/phase1-vision.md`) |
| **Status** | Icon | `Draft` \| `In Review` \| `Approved` \| `Archived` | Current stage of the document lifecycle |
| **Version Id** | Icon | | Standard semver notation (e.g., `v0.1`, `v1.0`) |


# 2. Legend & Conventions

## Version Id
Follows the pattern `v<major>.<minor>` of [semantic versioning][semantic versioning whatis]


## Document Id

Follows the pattern `<PP><PSeq>-<CAT>-<DSeq>-<PROJ>`:
* **PP (Project Phase):** Identifies the project lifecycle stage (`PP1` through `PP4`).
* **ID:** Two-digit numerical index of the document within its phase (e.g., `01`, `02`).
* **Project Code:** Short code name for the project (e.g., `RMS` for *Resource Management System*).

| Token | Name | Description / Values | Example |
| --- | --- | --- | --- |
| **`PP`** | **Project Phase Prefix** | Constant prefix indicating a project phase | `PP` |
| **`PSeq`** | **Phase Sequence** | Numerical index of the project phase (`1`, `2`, `3`, `4`) | `1` |
| **`CAT`** | **Category Code** | 3-letter functional domain identifier | `REQ` |
| **`DSeq`** | **Document Sequence** | Two-digit numerical index of the document within that phase/category (`01`, `02`, ...) | `01` |
| **`PRJ`** | **Project Code Name** | Short project code name | `BLUE` |


**Category Code (`CAT`) Identifier**

| Category Code | Domain | Typical Contents |
| --- | --- | --- |
| **`OVR`** | Overview | High-level goals, scope, charter, terminology, and business validation |
| **`TER`** | Terminology | Vocabulary, concepts, glossary |
| **`REQ`** | Requirements | Functional/non-functional specs, constraints, execution models, and compliance |
| **`DOM`** | Domain Model | Data models, entities, relationships |
| **`EXE`** | Execution Model | Intent decomposition, runtime lifecycle |
| **`ARC`** | Architecture | System components, boundaries, security,Technical blueprints, data models, API contracts, and interface specs |
| **`INT`** | Interfaces | CLI specs, APIs, agent contracts |
| **`EXT`** | Extensibility | Plugins, mechanism wrappers |
| **`IMP`** | Implementation | Code structure, module contracts |
| **`TST`** | Testing | Test plans, validation scenarios, deployment guides, implementation blueprints, and user |
| **`OPS`** | Operations | Installation, deployment, user guides |

**Examples of usage**

* **`PP1-OVR-01-BLUE`** $\rightarrow$ Phase 1 (Project Definition), Overview, Doc #01
* **`PP1-TER-02-BLUE`** $\rightarrow$ Phase 1 (Project Definition), Terminology, Doc #02
* **`PP1-REQ-03-BLUE`** $\rightarrow$ Phase 1 (Project Definition), Requirements, Doc #03
* **`PP2-EXE-01-BLUE`** $\rightarrow$ Phase 2 (Behavior & Architecture), Execution Model, Doc #01
* **`PP2-ARC-02-BLUE`** $\rightarrow$ Phase 2 (Behavior & Architecture), Component Design, Doc #02
* **`PP3-INT-01-BLUE`** $\rightarrow$ Phase 3 (Interfaces), CLI Specification, Doc #01
* **`PP4-IMP-01-BLUE`** $\rightarrow$ Phase 4 (Implementation), Implementation Blueprint, Doc #01


## Status Definitions
* 🟡 **`Draft`**: Work in progress; contents are subject to major structural changes.
* 🔵 **`In Review`**: Content complete; awaiting peer, technical, or stakeholder review.
* 🟢 **`Approved`**: Reviewed, signed off, and frozen as an active project baseline.
* 🔴 **`Archived` / `Superseded`**: Obsolete document maintained solely for historical audit trails.


# 3. Example Usage

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v0.1-blue)

| Field | Value |
| :--- | :--- |
| **Doc ID** | `PP1-01-RMS` |
| **Path** | `docs/phase1-vision.md` |