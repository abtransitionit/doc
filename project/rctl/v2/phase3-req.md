[//]: #\(home\)
[home domain]: ../../README.md
[home doc]: ../../../README.md

[↖ Project][home domain] · [↖ Doc][home doc]

[//]: #\(doc\)
[res whatis]: #
[res kind whatis]: #
[ope whatis]: #
[res cap whatis]: #
[host whatis]: #
[res mechanism whatis]: #
[host wrap whatis]: #
[action whatis]: #
[plan whatis]: #
[intent whatis]:
[request whatis]; #
[system whatis]: #
[target context whatis]: #
[target composition whatis]: #

Related topics

| Topic                            | Location | Kind |
| -------------------------------- | -------- | ---- |


<h1 align="center">Project RMS - Phase2: Requirements Specifications</h1>

RMS aka. Resource Management System

|Param|value|
|-|-|
| Document ID | PP3-RMS
| Path | `phase2-term.md`  
| Status | Draft  
| Version | 0.1 |

Keep this document concise and structured around **what the system must/shall do**, **without prescribing how it must be implemented**.


| Section                        | Content                                                                                                           |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| 1. Purpose                     | The role of the requirements document.                                                                            |
| 2. Functional Requirements     | Resource management, operations, interfaces, intents, execution plans, actions, requests, and execution tracking. |
| 3. Non-Functional Requirements | Extensibility, reliability, security, observability, and maintainability.                                         |
| 4. Constraints                 | Known boundaries and restrictions.                                                                                |
| 5. Acceptance Criteria         | How we determine whether the requirements are satisfied.                                                          |

The first fundamental question is:

Should the system support both direct operation requests (for example, “stop this VM”) and high-level intents (for example, “install this package on that VM”), with the latter decomposed into execution plans when necessary?