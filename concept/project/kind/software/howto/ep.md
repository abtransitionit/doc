[//]: #(home)
[home set]:    ../../../../README.md
[home doc]:    ../../../../../README.md
[home parent]: ../../../whatis/ep.md

[↖ Project][home parent] · [↖ Concept][home set] · [↖ Doc][home doc]

[//]: #(ref)
[project software whatis]: ../whatis/ep.md
[lfc whatis]:         ../../../concept/lifecycle/whatis/ep.md
[prj roadmap whats]:  ../../../concept/lifecycle/whatis/roadmap.md
[prj lfc whatis]:     ../../../concept/lifecycle/whatis/ep.md#sproject


Related topics

| Topic | Location | Kind |
|-|-|-|
|[What is a Software project][project software whatis]|internal



<h1 align="center">How-to for Software Project</h1>

The concept of software project Howto

# Howto

This kind of project must manage both:
- a project lifecycle (timeline, milestones, progress) 
- a software lifecycle (codebase, features, documentation, bug tracking)


To achieve this seamlessly, one approach is to clearly separate:
- The Software Artifacts (what is build) 
- The Project Activities (how it is build)

and then link some of their components together.


|#|step|description|
|-|-|-|
| 1 | The Core Split | Separate software documentation from project documentation cleanly.
| 2 | Structuring the Software Hub | Keep software guides (ref, user, admin) current and independent from the project lifecycle.
| 3 | Structuring the Project Hub | Manage Roadmap, Sprint/Phase Progression, Design, and Bug Tracking without cluttering software docs.
| 4 | The Linkage Strategy | Connect Project progress to Software documentation without duplicating work.
| 5 | Tooling & Setup Architecture | Define a concrete workspace structure with tools such as Notion, Confluence, or Markdown Git

# Step 01: The core split

Split your documentation into two distinct spaces: 
- **Software Space**: what the system is (**Evergreen** documentation)
- **Project Space**: what is happening right now (**Ephemeral** documentation)


| Feature | Software Space (Evergreen) | Project Space (Ephemeral) |
| --- | --- | --- |
| **Purpose** | Single source of truth for the product | Dynamic tracking of execution and progress |
| **Lifecycle** | Long-term; lives as long as the software exists | Short-term; closes when the phase/milestone ends |
| **Target Audience** | End users, admins, future developers | Stakeholders, current dev team, project managers |
| **Key Contents** | Admin Guide, Reference Guide, Architecture, User Manuals | Roadmaps, Design Specs (in-progress), Bug Backlog, Sprint Logs |
| **Update frequency** | on release/deployment | daily or weekly |


## The Golden Rule

> **Never write project status inside software manuals.**

* **Bad Practice:** Writing *"We are currently working on feature X in release 2.0"* directly inside the User Guide.
* **Best Practice:** The User Guide only documents feature X *after* it is released. The Project Space tracks feature X while it is being built.

# Step 02: Structure the Software Hub

- It holds all **Evergreen** documentation. 
- Its structure is static and independant of the actual phase you are in the project. 
- It descibes:
  - what the software does.
  - how to use it.
  - how to maintain it right now.


The Software Space can be organize into the following sections:

||||
|-|-|-|
| Architecture    | | High-level system architecture diagrams. |
| Getting Started | | Core capabilities and high-level tech stack. |
| User Guide      | | Step-by-step guides for day-to-day users |
| Admin Guides    | | Deployment, configuration, environment variables, user roles, security settings, and backup/restore procedures. |
| Reference Documentation | API Reference | Endpoints, request/response payloads, error codes (or links to OpenAPI/Swagger specs).|
| Reference Documentation | Data Model / Schema | ER diagrams, dictionary of key entities, database migrations logic.|
| Operations & Maintenance | Troubleshooting Guide |Common error codes, log interpretations, known workarounds.
| Operations & Maintenance | Release Notes / Changelog |Archival record of what changed in each official version bump.




## The Golden Rule

> **Keep draft features out of this hub.**

- Until code is actually merged to main or deployed, it lives strictly in the **Project Hub**. 
- Once released, draft documentation moves over into this structure.


# Step 03: Structure the Project Hub

- It holds all **Ephemeral** documentation. 
- This is where your day-to-day activities lives: 
  - progress tracking
  - draft designs, 
  - Active work items not yet ready for the Evergreen Software Hub.

The Project Space can be organize into the following sections:

||||
|-|-|-|
| Strategic Planning (The Roadmap) | **Project Charter:** Goals, scope, target deliverables, and stakeholders.
| Strategic Planning (The Roadmap) | **Milestone Roadmap:** High-level timeline detailing target delivery dates for major phases.
| Design & Discovery (In-Flight Work) | **RFCs / Technical Design Docs:** Draft architecture specs, technical proposals, and UX mockups currently being debated or refined.
| Design & Discovery (In-Flight Work) | **Decision Logs (ADRs):** Records of key decisions made during the design phase so you do not repeat past debates.
| Execution & Progression | **Phase / Sprint Pages:** Active status updates showing current progress against the roadmap.
| Execution & Progression | **Status Reports:** Weekly or monthly summaries for stakeholders highlighting achievements, risks, and blockers.
| Issue & Quality Tracking | **Bug Backlog:** Active bug reports categorized by severity, current owner, and resolution status.
| Issue & Quality Tracking | **Feature Backlog:** Unplanned or future enhancements submitted during current development.




## The Golden Rule
- Never manually re-write design documents into software manuals.
- Use "Draft-to-Publish" Templates when writing a Technical Design Document in the Project Hub
  - use the exact structure required by your **Software Hub** (e.g., Architecture, Data Model, API Specs). 
  - Once the code is shipped, simply change the page status from Draft to Published
  - Move or link the document straight into the **Software Hub**.
- Convert Notes to Architecture Records: 
  - Discussion threads, rejected options, and meeting notes stay archived in the Project Hub for history. 
  - Only the final selected design gets moved or referenced in the **Software Hub** as the official system architecture.  
- Single Source of Truth:
  - Embed or link the final spec directly so you maintain zero duplicate copy.


# Specification lifecycle Across the project Lifecycle

||||
|-|-|-|
| 1 | Discovery Phase | <li>Gather requirements <li>Write a **Draft Spec** <li>It contains open questions, proposed solutions, and alternative ideas.
| 2 | Design Phase | <li>The draft is refined <li>It hold reviews, and make choices.  <li>Once decisions are approved, it becomes the **Final Spec**. <li>It acts as the exact blueprint for your developers.
| 3 | Development & Testing | <li>Devs build against this Final Spec.  <li>If minor tweaks happen during coding, you update this document in place so it stays accurate.
| 4 | Release / Deployment | <li>Once the feature is shipped <li>Strip away the project-specific fluff (discussion notes, open questions) <li>Move this spec directly into the **Software Hub** as permanent architecture documentation.


# Step 4: The Linkage Strategy
- When a project phase ended
  - some **Project** (Ephemeral) document get **Software** (Evergreen) documentation
- The key is to link some **active project work** to **static** software document.


The following links may be usefull:

||src|dst||
|-|-|-|-|
| 1 | Feature | Spec |(Design & Dev) | link a blueprint (static spec) to a current dev task |
| 2 | Release  | Changelog | (Software Hub ↔ Project Hub)**
| 3 | Known Bug | User Guide|  (Operations ↔ Backlog)**

| Link Type | Origin (Where you are) | Destination (Where it points) | Purpose |
| --- | --- | --- | --- |
| **Active Task** | Project Board (Task / Bug) | Project Hub (Draft/Final Spec) | Devs access spec via their tasks |
| **Release Note** | Software Hub (Changelog) | Project Hub (Milestone Summary) | Stakeholders access project history via  a release |
| **Workaround** | Software Hub (Troubleshooting) | Project Hub (Bug Backlog) | Gives users a workaround while the bug ticket stays open |


* Every active project card, Jira issue, or task must contain a direct link to its corresponding spec (which starts as a draft spec in the Project Hub and will eventually move to the Software Hub).
* **Result:** Developers don't dig through folders; they click one link on their task board to see the exact blueprint.


* When a project milestone finishes, tag the release in your Software Hub Changelog (e.g., `v2.0 - Released Sept 2026`).
* Link that Changelog entry back to the Project Hub milestone summary page.
* **Result:** Anyone looking at the current software can click through to see *why* and *when* a set of features was introduced historically.


* If a active bug in the Project Hub affects current users and has a workaround, mention the workaround in the Software Hub **Troubleshooting Guide**.
* Hyperlink the workaround directly to the live bug ticket in your Project Hub backlog.
* **Result:** When the bug is fixed and closed in the Project Hub, you remove the workaround note from the Software Hub.



## The Golden Rule

- Project tasks point to Software specs
- Software changelogs point back to Project milestones.

- Project items point to blueprints
- Software logs point back to project history.**

# Step 5: Tooling & Setup Architecture

- This is where the theory becomes reality. 
- It focus on creating 
  - the software hub as a folder tree
  - the project hub as a folder tree
  - the project board


## The Software Hub (The Permanent Library)

**Permissions**: Read-only for most, Edit for tech leads/writers

```yaml
Software Hub: Name of the product
  ├─ 1. System Overview & Architecture (High-level diagrams)
  ├─ 2. User Manuals
  │   ├─ Getting Started
  │   └─ Core Features Guide
  ├─ 3. Admin & Operations
  │   ├─ Deployment & Configs
  │   └─ Troubleshooting Guide
  ├─ 4. Developer Reference
  │   ├─ API Specs
  │   └─ Data Model & Schema
  └─ 5. Release Notes / Changelog
      ├─ v1.0.0 (Link to Project Milestone)
      └─ v1.1.0 

```

## The Project Hub (The Workshop)

**Permissions**: Edit access for the whole project team

```yaml
Project Hub: Name of the project/team
  ├─ 1. Master Roadmap (Timeline and Goals)
  ├─ 2. Design Specs & RFCs (In-flight Work)
  │   ├─ Feature X (Draft) -> [Will move to Software Hub once built]
  │   └─ Feature Y (Approved)
  ├─ 3. Sprints & Milestones
  │   ├─ Sprint 1 Status
  │   └─ Sprint 2 Status
  └─ 4. Meeting Notes & Decision Logs
      ├─ Architecture Decision Records (ADRs)
      └─ Weekly Syncs

```

## The Project Board (The Execution Engine)

**Permissions**: Edit access for the whole project team.

This sits alongside your Project Hub and acts as your day-to-day tracker.

* **Columns:** Backlog ➔ Up Next ➔ In Progress ➔ In Review ➔ Done.
* **Tickets:** Every ticket here includes a hyperlink pointing to a Design Spec in the Project Hub.


## How this maps to popular tools

* **If you use Atlassian:** Create two **Confluence Spaces** (one for Software, one for Project). Use **Jira** as your Project Board. Link Jira tickets to Confluence pages.
* **If you use Notion:** Create two main **Pages** (one for Software, one for Project) in your sidebar. Create a **Database Board** inside the Project Page for your Project Board.
* **If you use GitHub / GitLab:** Put your Software Hub in a `/docs` folder in the repo (or a Wiki). Put your Project Hub in a separate Wiki or Planning Repo. Use **GitHub Projects / Issues** as your Project Board.

