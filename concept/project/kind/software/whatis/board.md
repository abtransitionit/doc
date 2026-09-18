# Definition

The board tracks active engineering tasks, pull requests, sprint items, and phase milestones—which are all software development concerns rather than operator concerns.

# Project board
The **`doc/board/board.md`** file sits inside a specific project repository, so **it concerns only that single software project** (e.g., `rctl`).

* **Scope Cohesion:** It tracks task-level execution (like `TASK-01` through `TASK-08`), phase gates, and pull requests specific to `rctl`'s codebase.
* **Traceability:** Keeping it inside `doc/board/` ensures that as you branch, version, or archive the `rctl` repository, its task board history stays strictly tied to the code it tracks.

# Multiple Projects board

If you are managing an **Enterprise Portfolio** or **Multi-Project System**, you would maintain a higher-level root board at `doc/board/` outside of individual project directories:

* **Global/Portfolio Board (`/doc/board/`):** Tracks cross-project milestones, shared dependencies, and release synchronization across multiple software tools (e.g., `rctl`, `auth-service`, `deploy-agent`).
* **Project-Specific Board (`/doc/project/rctl/log/backlog.md` or `/doc/project/rctl/board.md`):** Tracks low-level implementation tasks exclusively for that single tool.



Placing it at **`doc/project/rctl/board.md`** (or keeping it in `doc/project/rctl/log/backlog.md`) is cleaner because:



### Complete Consolidated Directory Layout

```text
doc/
├── project/rctl/              <-- Engineering & Lifecycle Hub
│   ├── adr/                   # Architecture Decision Records
│   ├── log/
│   │   ├── backlog.md         # Master Task Backlog
│   │   ├── lifecycle.log.md   # Lifecycle Execution Log
│   │   └── tasks/             # Task Execution Files (TASK-01 to TASK-08)
│   ├── spec/                  # Requirements, Vision, Architecture Specs
│   ├── whatis/
│   │   └── ep.md              # Evergreen Project Hub
│   └── board.md               <-- [NEW] Active Project Execution Board
│
└── tool/rctl/                 <-- Operator & User Hub
    ├── README.md              # Tool Hub Onboarding Index
    ├── admin/                 # Security & Admin Guides
    ├── howto/                 # Quickstarts & Inventory Setup
    ├── list/                  # Capabilities & Feature Matrix
    ├── ref/                   # CLI Reference & Exit Codes
    └── whatis/                # Product Overview

```
