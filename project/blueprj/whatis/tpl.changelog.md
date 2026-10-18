[//]: # (home)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep2.md

[↖ Blue Project][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: # (doc)
[changelog whatis]: https://keepachangelog.com/en/1.1.0/
[semantic versioning whatis]: https://keepachangelog.com/en/1.1.0/

<div align="center">

# Project: Blue — Project Changelog Template

A global changelog template 

![Status](https://img.shields.io/badge/Status-Draft-yellow)
![Version](https://img.shields.io/badge/Version-v1.0-blue)

</div>

| Field | Value |
| :--- | :--- |
| **Doc ID** | TPL-CL-BLUE |
| **Path** | `tpl.changelog.md` |
| **Last Updated** | 2026-10-18 |


# Requirements

The project shall maintains a global changelog that adheres to [Keep a Changelog][changelog whatis] standard and  [Semantic Versioning][semantic versioning whatis]. It keeps tracks of cross-cutting project updates across:
* Document release baselines
* Major decision milestones
* Architectural deliverables
* Software releases and system updates


# Reference Labels

When logging changes, group items using these standard section categories:

| Category | What to Log |
| :--- | :--- |
| **Baseline Documents** | Key document IDs and version numbers frozen or approved in this release. |
| **Added** | New documents, features, specifications, or architectural components. |
| **Changed** | Modifications to existing requirements, designs, or project scope. |
| **Deprecated** | Features or specifications marked for removal in upcoming versions. |
| **Removed** | Features, documents, or requirements officially dropped from scope. |
| **Fixed** | Corrections to mistakes, ambiguous specs, or conflicting requirements. |
| **Security** | Security mitigations, vulnerability fixes, or compliance audit updates. |


# Example of Usage

# [Unreleased]

## Added
- Drafted initial Technical Design Document (`PP3-01-TDD.md`) for core API architecture.

## Changed
- Updated system deployment target from local VM hosting to cloud containers in `PP2-02-Architecture.md`.

---

# [1.0.0] - 2026-12-14

## Baseline Documents
- `PP1-01-RMS`: Vision & Scope (`v1.0`)
- `PP2-01-RMS`: Functional Requirements (`v1.0`)
- `PP2-02-RMS`: High-Level Architecture (`v1.0`)

## Added
- Completed initial release of project blueprint templates and metadata standards.
- Finalized core business requirements and stakeholder sign-offs for Phase 1.

## Security
- Completed initial threat modeling review for external identity providers.

---

# [0.2.0] - 2026-11-18

## Added
- First complete draft of the Functional Requirements specification (`PP2-01-RMS`).

## Fixed
- Corrected conflicting database retention requirements between `PP1-01` and `PP2-01`.

---

# [0.1.0] - 2026-10-18

## Added
- Initial project kickoff repository setup.
- Added Project Vision & Scope document (`PP1-01-RMS`, `v0.1`).
