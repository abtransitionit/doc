[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md
[home topic]: ../whatis/ep2.md

[↖ Blue Project][home topic] · [↖ Project][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)

Related topics

| Topic                            | Location | Kind |
| -------------------------------- | -------- | ---- |


<h1 align="center">Project: Blue - Document Metada Template</h1>

A **Matadata** template for each project's document


| Field | Value | Description / Options |
| --- | --- | --- |
| **Document ID** | `<PP><ID>-<Project Code>` | e.g., `PP1-01-RMS` |
| **Path** | `<filename.md>` | Relative file path in repository |
| **Status** | `Draft` | `In Review` | `Approved` | `Archived` | Current stage of the document |
| **Version** | `v<Major>.<Minor>` | Standard semver notation (e.g., `v0.1`, `v1.0`) |

**Metadata Key & Conventions**

* **PP (Project Phase):**
* `PP1`: Vision & Scope
* `PP2`: Requirements & Planning
* `PP3`: Design & Architecture
* `PP4`: Execution & Delivery


* **ID:** Numerical index of the document within the phase (e.g., `01`, `02`).
* **Project Code:** Unique short acronym for the project (e.g., `RMS` for *Resource Management System*).


**Example Metadata Block**

| Field | Value |
| --- | --- |
| **Document ID** | PP1-01-RMS |
| **Path** | `docs/phase1-vision.md` |
| **Status** | Draft |
| **Version** | v0.1 |

