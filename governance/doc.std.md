[//]: #(Home)
[home]: ../README.md
[Top]: #

[system stage]:    ./stage.md#-stages-for-a-system-lifecycle
[project stage]:   ./stage.md#-stages-for-a-project-lifecycle
[Controlled vocabulary list]:           ./cv.md
[term.kind list]:    ./term.kind.md
[acronym list]:      ./acronym.md
[doc improve whatis]: ./doc.std.improve.md 

[←][home]

<h1 align="center">Documentation Standard</h1>


# Purpose

This document defines how organization's IT documentation is created, organized, classified, maintained, and discovered. It describes the **documentation system**, not the technical content of individual systems or projects.

For contribution. cf. [Improve the documentation standard][doc improve whatis]

---

# Reference

- [Controlled classification][term.kind list]
- [Controlled vocabulary][Controlled vocabulary list]
- [Acronyms][acronym list]


---

# [↑][Top] Core Principles when writing documentation

## Document's metadata

Each document may have metadata or property for classification and discovery such as:

| Attribute | Purpose | Example |
|-|-|-|
| **Audience** | Identifies who uses or reviews the document. | Architect, Developer, Operations, End user |
| **Lifecycle stage** | Identifies the document's position in the system or project lifecycle. | Planning, Requirements, Design, Build, Deployment, Operation, Retirement |
| **System / Project** | Identifies the system, service, product, or project concerned. | CRM, Kubernetes Platform, Project Alpha |
| **Domain** | Identifies the relevant business or technical domain. | Security, Networking, Finance, Data |
| **Document type** | Identifies the nature of the document. | Requirement, ADR, Architecture, Runbook, User guide |
| **Owner** | Identifies who is responsible for maintaining the document. | IT Operations, Security Team, Project Manager |
| **Status** | Identifies the document's current state. | Draft, Active, Deprecated, Archived |


For example, Documents may use metadata in header such as:

```yaml
---
system: Kubernetes
lifecycle: Architecture
audience:
  - Engineering
  - Operations
domain: Infrastructure
kind: Architecture
owner: Engineering
status: Active
---
```

## Audiences and document kinds

A document may have multiple audiences. Typical audiences include:

| Audience | Description | Typical Documentation |
| - | - | - |
| **End Users** | Person who uses a system or service to perform daily activities. | <li>User manuals <li>user procedures <li>FAQs <li>Support and service documentation<li>**L1 support** |
| **Business users** | Person or group concerned with business needs, processes, and outcomes. |<li>Business requirements <li>process documentation <li>project overview |
| **Engineering and development teams** | Team responsible for designing, developing, and implementing systems. | <li>Requirements, <li>architecture documentation <li>design specifications <li>development guides <li>L3 support|
| **IT Operations teams** | Team responsible for deploying, operating, monitoring, and supporting systems. | <li>Operational documentation <li>deployment guides <li>runbooks <li>Monitoring, backup, recovery, and incident procedures <li>L2 support|
| **Governance and stakeholders** | Person or group responsible for oversight, compliance, risk, and decision-making. | <li>Decision records <li>compliance documentation <li>risk documentation <li>governance records |
| **Contributor** | Person who creates, maintains, or contributes to documentation, systems, or projects. | <li>Contribution guides <li>documentation standards <li>development guidelines |
| **Sponsor** | Person or organization providing strategic support, funding, or organizational ownership. | <li>Project overview <li>funding documentation <li>governance documentation |
| **Corporate / Internal Services** | Internal service responsible for supporting organizational activities. | <li>Service documentation <li>user procedures <li>support documentation |
| **Cross-cutting / Reference** | | <li>**Definitions and controlled vocabulary** <li>Standards, conventions, and guidelines |

## Lifecycle

Documentation follows the lifecycle of projects and systems.

**Project lifecycle [stages][project stage]**
```
Business idea → Project initiation → Project planning → Requirements and scope → Design → Development and implementation → Delivery and transition → Project closure → Lessons learned
```

**System lifecycle [stages][system stage]**
```
Business and user needs → Requirements → Business design → Architecture → Technical design → Development → Testing and validation → Deployment → Production operation → Monitoring and support → Maintenance and evolution → Continuous improvement → Retirement
```


# [↑][Top] Project and System Lifecycles

| lifecycle| stages|
|-|-|
| **Project lifecycle** | Business idea ➔ Project initiation ➔ Project planning ➔ Requirements and scope ➔ Design ➔ Development and implementation ➔ Delivery and transition ➔ Project closure ➔ Lessons learned |
| **System lifecycle** | Business and user needs ➔ Requirements ➔ Business design ➔ Architecture ➔ Technical design ➔ Development ➔ Testing and validation ➔ Deployment ➔ Production operation ➔ Monitoring and support ➔ Maintenance and evolution ➔ Continuous improvement ➔ Retirement |



Other document kind may be: 

* Concept
* Requirements
* Architecture
* Design specification
* User guide
* Deployment guide
* Runbook
* Decision record (ADR)
* Risk assessment
* Procedure
* Reference


---

# [↑][Top] Authoritative document

When creating documents:
- A document should have a **single authoritative content**.
- Links, references, indexes, REAMDE or metadata should make it discoverable from different perspectives. 
- This approach
  - Avoids creating separate copies of the same information for different audiences in different location.
  - Reduce duplication, prevents conflicting versions, and improves traceability across the documentation lifecycle.


For example, **One architecture document**
- → owned by Engineering
- → relevant to Operations
- → reviewed by Governance
- → linked from the corresponding system documentation

---

# [↑][Top] README files

- `README.md` are navigation indexes. 
- They primarily explain what is available in a directory and provides links to the authoritative documents.
- For example, one architecture document may be linked from:
  * the system README
  * an operations index
  * a governance index
  * a project README

---

# [↑][Top] Where does files live

Example of a directory structure

```text
reference/
├── README.md
├── concepts/
│   ├── README.md
│   ├── security.md
│   ├── observability.md
│   └── resilience.md
│
├── terminology.md
└── standards/
    └── README.md
```

Example of file location according to their content

|topic|location|
| a Kubernetes security guide | `systems/kubernetes/...` |
| a security operational procedure | → `operations/...` |
| a security runbook | `operations/runbooks/...` |
| a security architecture | `systems/.../architecture.md` |
| a security policy | `governance/...` |
| a security standard | `reference/standards/...` |


> **If a document explains a general concept independently of a particular system or project → `reference/concepts/`.**

For example this is the case for the following topics:

```text
reference/concepts/
├── security.md
├── resilience.md
├── availability.md
├── fault-tolerance.md
├── scalability.md
├── observability.md
└── incident-management.md
```

---


# [↑][Top] Cross-cutting concerns

The following concerns apply throughout the lifecycle:


| Concern | Purpose | Examples |
| - | - | - |
| **Governance** | Provide decision-making, oversight, accountability, and control throughout the lifecycle | Decisions, approvals, steering, reporting, compliance |
| **Risk management** | Identify, assess, monitor, and mitigate risks throughout the lifecycle | Risk register, mitigation plans, risk reviews |
| **Documentation management** | Ensure that relevant documentation is created, maintained, reviewed, and made accessible | Versioning, reviews, ownership, traceability |
| **Change management** | Control and communicate changes that may affect the project or system | Change requests, impact analysis, approvals |
| **Stakeholder management** | Identify, involve, and communicate with relevant stakeholders | Stakeholder mapping, communication, feedback |

# Versioning documents (💡)
Documents must be versioned. Even `.md` files

Example:
```
Pegasus-Roadmap-v2.1-2026-08-26.md
Aurora-Architecture-v3.0.md
Phoenix-Security-Final.md
```


# Howto classify documents (💡)


### **🔹 Core Strategic Documents (The "Why")**
| Document | Purpose |
|----------|---------|
| **Charter** | Project authorization & scope |
| **Business Case** | ROI, justification, cost-benefit |
| **Roadmap** | Timeline, milestones, phases |

### **🔹 Architecture & Design (The "How")**
| Document | Purpose |
|----------|---------|
| **Architecture** | System design, components, patterns |
| **Technical Design** | Detailed implementation specs |
| **Data Model** | Database schemas, ERD, relationships |
| **Infrastructure** | Servers, networks, cloud topology |
| **Integration** | APIs, message flows, system interactions |
| **Security** | Auth, encryption, compliance framework |

### **🔹 Planning & Execution (The "When")**
| Document | Purpose |
|----------|---------|
| **Project Plan** | Tasks, dependencies, resources |
| **Sprint Plan** | Agile iteration backlog |
| **Release Plan** | Versioning, deployment schedule |
| **Test Plan** | QA strategy, test cases, UAT |

### **🔹 Operational (The "Run")**
| Document | Purpose |
|----------|---------|
| **Runbook** | Operations procedures, troubleshooting |
| **Deployment** | Installation, config, migration steps |
| **Maintenance** | Updates, backups, monitoring |
| **DR Plan** | Disaster recovery, business continuity |

### **🔹 Governance & Compliance**
| Document | Purpose |
|----------|---------|
| **RACI** | Roles & responsibilities matrix |
| **SLA** | Service level agreements |
| **Risk Register** | Risk assessment, mitigation |
| **Compliance** | Regulatory/legal requirements |


## **Quick Classification Flowchart**

```
Is it about WHAT we're doing?
  → Charter | Business Case | Roadmap

Is it about HOW we're building it?
  → Architecture | Technical Design | Data Model | Integration

Is it about WHEN we're doing it?
  → Project Plan | Sprint Plan | Release Plan | Test Plan

Is it about RUNNING it?
  → Runbook | Deployment | DR Plan | Maintenance

Is it about RULES & PEOPLE?
  → RACI | SLA | Risk Register | Compliance
```

---

## **Pro Tip: Use a Document Matrix**

Create a simple table for your project:

```markdown
| Artifact | Owner | Status | Location |
|----------|-------|--------|----------|
| Architecture | Alice | Draft | /docs/arch/ |
| Roadmap | Bob | Approved | /docs/plan/ |
| Security | Carol | Review | /docs/sec/ |
```

---

**Bottom line:** Call them **"Artifacts"** — it's professional, covers everything, and aligns with ITIL/Agile/DevOps terminology.

Want me to build you a full document template for any of these?