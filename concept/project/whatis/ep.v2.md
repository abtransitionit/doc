↖
Related topics
| Topic | Location | Kind |
| :--- | :--- | :--- |
| Project Framework | `concept/project/whatis/ep.md` | Entry Point |
| Machine Taxonomy | `concept/machine/whatis/ep.md` | Dependent Concept |
| Algernon Tooling | `tool/algernon/whatis/ep.md` | Infrastructure |

# Project Concept & Lifecycle

A **Project** is an ephemeral workspace designed to move a specific technical initiative from discovery to live production. Once a project completes its scope, its artifacts transition into permanent system documentation (`concept/`, `language/`, or `tool/`) and the project workspace is archived.

```text
Project Lifecycle Flow
├── 1. Discovery (RFC / Draft Spec in project/*/specs/)
├── 2. Implementation (Active work tracked in project/*/backlog.md)
├── 3. Promotion (Publish clean docs to concept/, language/, or tool/)
└── 4. Archival (Mark project status Done & archive workspace)