[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep2.md

[↖ Blue Project][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)

<div align="center">

# Project: Blue — Document Metadata Specification

A standardized metadata block specification and authoring template for project deliverables

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v1.0-blue)

</div>

| Field | Value |
| :--- | :--- |
| **Doc ID** | TPL-MTD-BLUE |
| **Path** | `tpl.metadata.md` |
| **Last Updated** | 2026-10-18 |

# 1. Requirements

Every project document shall include **at least** theses standardized metadata to maintain auditability, traceability, and version control.

| Field | Kind | Value | Description / Permitted Options |
| :--- | :--- | :--- | :--- |
| **Doc ID** | Header | `<PP><ID>-<Project Code>` | Unique document identifier (e.g., `PP1-01-RMS`) |
| **Path** | Header | `<filename.md>` | Relative file path in the repository (e.g., `docs/phase1-vision.md`) |
| **Status** | Icon | `Draft` \| `In Review` \| `Approved` \| `Archived` | Current stage of the document lifecycle |
| **Version** | Icon | `v<Major>.<Minor>` | Standard semver notation (e.g., `v0.1`, `v1.0`) |


# 2. Legend & Conventions

## Document ID Syntax
`Doc ID` follows the pattern `<PP><ID>-<Project Code>`:
* **PP (Project Phase):** Identifies the project lifecycle stage (`PP1` through `PP4`).
* **ID:** Two-digit numerical index of the document within its phase (e.g., `01`, `02`).
* **Project Code:** Short code name for the project (e.g., `RMS` for *Resource Management System*).

## Project Phase (PP) Codes
* **`PP1` – Vision & Initiation:** High-level goals, scope, charter, terminology, and business validation.
* **`PP2` – Requirements & Analysis:** Functional/non-functional specs, execution models, and compliance.
* **`PP3` – Architecture & Design:** Technical blueprints, data models, API contracts, and interface specs.
* **`PP4` – Execution & Operationalization:** Test plans, deployment guides, implementation blueprints, and user runbooks.

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