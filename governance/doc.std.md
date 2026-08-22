[//]: #(Reference)
[Top]: #
[home]: ../README.md
[k8s whatis]:      ./k8s.md
[Security whatis]: ./security.md
[Linux whatis]:    ./Linux.md
[system stage]:    ./stage.md#-stages-for-a-system-lifecycle
[project stage]:   ./stage.md#-stages-for-a-project-lifecycle


# [←][home] Documentation Standard

# Purpose

This document defines how organization's IT documentation is created, organized, classified, maintained, and discovered. It describes the **documentation system**, not the technical content of individual systems or projects.


---

# [↑][Top] Controlled classification

Terms can be classified using a small, controlled set of kinds:

| Kind       | Definition                                                                 | Example |
| ---------- | -------------------------------------------------------------------------- | ------- |
| Acronym    | Short form of a term or expression                                         | ACID, CRUD |
| Concept    | Abstract idea, principle, or model                                         | Observability, Resilience |
| Tool       | Software, application, framework, or utility                               | `kubectl`, `Terraform` |
| Technology | Technical approach or technology family                                    | Containers, REST |
| Platform   | Capabilities, services, or execution environment provided to other systems | Kubernetes, AWS |
| Standard   | Formal specification, rule, convention, or practice                        | ISO 27001, OpenAPI |
| Process    | Defined sequence of activities to achieve an objective                     | Incident Management |
| Project    | Temporary initiative with a defined objective, scope, and outcome          | Kubernetes Migration |

New kinds should only be introduced when an existing kind cannot accurately classify a term.

---

# [↑][Top] Controlled vocabulary

The controlled vocabulary defines preferred terms and their meaning. It ensures a consistent terminology and understanding across different audiences, teams, and documents.

| **Term** | **Definition / Usage** |
| - | - |
| Audience | Person or group (teams, stakeholder) expected to use, review, or contribute to a document. |
| Document | Structured information created, maintained, and shared to communicate or record knowledge, requirements, decisions, procedures, or other information. It may be relevant to multiple audiences. |
| Architecture documentation | Documentation describing the logical and technical architecture, including system structure, components, and interactions. |
| Controlled vocabulary | A shared and standardized set of terms used consistently across documentation. |
| Internal Services | Services provided within the organization to support its internal operations, rather than services delivered to external customers. |
| Decision record (ADR) | A traceable record of important technical or architectural choices and decisions and their rationale. |
| Deployment guide | Procedures for installing, upgrading, or rolling back a **system** |
| Design specification | Detailed description of the technical design of a **system** |
| End user | Person who uses a **system** in their daily activities or operations. |
| Governance | Decision-making, oversight, and control of a **system** or activity. |
| Operational documentation | Documentation required to operate, maintain, and support a **system** in production, pre-prod, dev, ... |
| Requirements | Functional and/or technical needs that a system must satisfy. |
| Runbook | Step-by-step instructions for performing operational tasks. |
| Stakeholder | Any person or entity with an interest in, or that may be affected by, the system, such as a business representative, sponsor, or regulator. |
| System | A whole or part of a framework, service, application, tool, ... |



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

