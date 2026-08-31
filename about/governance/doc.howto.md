[//]: #(Home)
[home]: ../README.md





[←][home]

<h1 align="center">Documentation Howtos</h1>


This document defines how to manage documents into the organization's IT documentation. All you need is an editor (the one used is `VSCode`) and a local clone of this git project.


# Add a new Project
1. create a folder under the `project` folder
1. Copy past a README file in its roots and adapt its content.
1. Preview the README, click on the link. You are asked to create the file. Go for it
1. Copy past the content from another same kind of and adapt its content.
1. Preview the markdown file, click on links to auto create files. And so on.

# Add a new document
1. Define the document type
1. Each document is a folder with at least a `README` files in its root.
1. Create a folder from scratch with that README file **or** copy past an existing folder, you will modify.

# Bootstrap a project
1. [Add a new document](#add-a-new-document)
1. [Create a roadmap](#build-a-project-roadmap) or a simple plan specifying the duration of each project milestone, phase, or stage.
1. As the project progresses, 
    - add files and content to the project
    - update the [roadmap table](#) and the [roadmap progression log](#).

# Manage Roadmaps
## Create a project's roadmap
- A roadmap define a project's phases, milestones, deliverables, and timelines. 
- It establishes the strategic direction and sets clear expectations for all parties involved.
- It provides stakeholders with a high-level view of a project
- See [example](../project/rctl/whatis/roadmap.md)

**progression markers used in a roadmpa are**:
- 🟡 In Progress — Currently working on this
- ✅ Done — Phase complete
- ⬜ Not Started — Not yet begun
- 🔴 Blocked — Waiting on something
- 🔁 Review — Phase done, under review

## Create a roadmap log to track project's activity
- A roadmap log enables teams to track project activity and progress over time.
- It serves as a single **source of truth (SOT)** for monitoring ongoing work. 
- It is maintained by the designated activity lead or task owner.
- See [example](../project/rctl/whatis/roadmap.log.md).

Use the following template to define a phase in the [roadmap progression log](#).
```
# 🟡 [Phase 1](./roadmap.md#-phase-1--design) <a id='phase-1'></a>
- [Status](#-p1-status)
- [Log](#-p1-log)
- [outcome](#-p1-outcome)
## [↑](#phase-1) 📍 Status
## [↑](#phase-1) 📍 Log
## [↑](#phase-1) 📍 Outcome
```

**When adapting the template:**
- Replace `Phase 1` with your actual phase name
- Replace `phase-1` with a matching ID (e.g., `design-phase`, `dev-phase-2`)
- Update the status marker (🟡 / ✅ / ⬜ / 🔴 / 🔁) to reflect current progress
- Adjust section links (`#-p1-status`, `#-p1-log`, `#-p1-outcome`) to match your phase ID


