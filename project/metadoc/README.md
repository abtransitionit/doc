# [↖](../README.md) [MetaDoc](whatis/ep.md)



# Todo

# Purpose
- This Git repository is serves as a centralized IT knowledge base, documentation, and single source of truth for the organization.
- It provides structured, consistent documentation covering the full **lifecycle** of **initiatives, projects, standards, systems, ...**.

# How Documentation Is Organized

To keep documentation easy to discover, content is structured along two core concepts:

1. **DocType** (The Subject): Organizes content by domain or scope (`project/`, `system/`, `reference/`, `governance/`, `domain/`).
2. **ContentType** (The Intent): Classifies files by purpose (`whatis/`, `howto/`, `list/`).
   * Writers: Stop getting stuck asking, "Where should I put this file?"
   * Readers: Immediately understand whether a document is a concept, a guide, or a reference list.

# Key Benefits

This structure provides a clean foundation designed for long-term maintainability:

* **Scalable:** The repository can absorb hundreds of new systems and projects without becoming messy or disorganized.
* **Extensible:** New **DocTypes** (e.g., `product/`, `vendor/`) or **ContentTypes** (e.g., `adr/`, `postmortem/`) can be added seamlessly as the organization grows and its documentation requirements evolve.


# Documentation standard

The [Documentation Standard][doc std] defines how documentation is organized, classified, maintained, and linked.


# Contributing

See the [Documentation Standard][doc std] for documentation principles, metadata, lifecycle, audiences, and document types.


# Howto Start documenting

See the [Howtos](./governance/doc.howto.md) to onboard with writing documents


# Purpose
* This repository serves as **`abtransitionit`**'s centralized IT knowledge base and single source of truth.
* It provides structured, consistent documentation covering the **full lifecycle of IT initiatives** (systems, projects, domains, and standards).
* All content is organized by intent using standard **DocTypes** (`whatis`, `howto`, `list`) to serve developers, architects, and operational teams.

---

# Taxonomy & DocTypes

To maintain clarity across all domains, every document follows a strict intent-based classification:

* **`whatis/` (Explanations & Architecture):** Concepts, system designs, background context, and decisions (*Why it exists / What it is*).
* **`howto/` (Procedural Guides):** Step-by-step actionable instructions for completing specific tasks (*How to accomplish X*).
* **`list/` (Catalogs & References):** Structured data, inventories, lookup tables, and registers (*Where to find X*).

---




---

# Governance & Standards

* **Rules & Conventions:** Read the [Documentation Standard][doc std] to learn how documents are classified, maintained, and cross-referenced.
* **Writing Guides:** Follow the [Documentation How-To][doc howto] for step-by-step instructions on creating and submitting new docs.

---

# Contributing

1. Review the [Documentation Standard][doc std] for formatting, metadata (Front Matter), and file naming guidelines.
2. Ensure new documents are placed in the appropriate `whatis/`, `howto/`, or `list/` subfolder.
3. Validate all relative Markdown links before opening a Pull Request.




# Purpose

- This Git repository is the main entry point for the organization’s documentation.
- Its purpose is to provide a consistent and structured documentation covering the **full lifecycle of IT initiatives**
- The documentation is organized to serve different audiences involved in the **lifecycle of a system or project**.



# Terminology





## [↑][Top] Controlled vocabulary

- This **shared vocabulary** defines the preferred translations and usage of **selected terms** commonly used in IT documentation. 
- It ensures a consistent terminology and understanding across different audiences, teams, and documents.

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


# [↑][Top] Project and System Lifecycles

| lifecycle| stages|
|-|-|
| **Project lifecycle** | Business idea ➔ Project initiation ➔ Project planning ➔ Requirements and scope ➔ Design ➔ Development and implementation ➔ Delivery and transition ➔ Project closure ➔ Lessons learned |
| **System lifecycle** | Business and user needs ➔ Requirements ➔ Business design ➔ Architecture ➔ Technical design ➔ Development ➔ Testing and validation ➔ Deployment ➔ Production operation ➔ Monitoring and support ➔ Maintenance and evolution ➔ Continuous improvement ➔ Retirement |


## [↑][Top] Stages for a Project lifecycle

| Stage | Purpose | Examples |
| - | - | - |
| **Business idea** | Identify an opportunity, problem, or need that may require a project | Business need, opportunity, initial objectives, initial scope |
| **Project initiation** | Formally start the project | Objectives, stakeholders, business case, scope, governance, initial risks |
| **Project planning** | Define how the project will be delivered | Schedule, resources, risks, activities, deliverables, budget |
| **Requirements and scope** | Define what the project must deliver and its boundaries | Business requirements, functional and non-functional requirements, scope |
| **Design** | Define the solution required to satisfy the requirements | Business design, architecture, technical design, specifications |
| **Development and implementation** | Build and configure the solution | Development, configuration, integration, testing, documentation |
| **Delivery and transition** | Deliver the solution and prepare it for operation | Deployment, release, handover, operational readiness, support transition |
| **Project closure** | Formally complete the project | Acceptance, closure report, final documentation, handover |
| **Lessons learned** | Capture experience and identify improvements | What worked, what did not work, recommendations, improvement actions |

## [↑][Top] Stages for a System lifecycle

| Stage | Purpose | Examples |
| - | - | - |
| **Business and user needs** | Identify the needs and expected outcomes of the system | Business needs, user needs, use cases, objectives |
| **Requirements** | Define what the system must provide and satisfy | Functional requirements, non-functional requirements, constraints |
| **Business design** | Define how the system supports business processes and user activities | Business processes, workflows, roles, use cases |
| **Architecture** | Define the overall structure and key components of the system | Logical architecture, components, interfaces, dependencies |
| **Technical design** | Define how the system will be technically implemented | Technical specifications, data models, APIs, infrastructure |
| **Development** | Build and configure the system | Code, configuration, integrations, infrastructure |
| **Testing and validation** | Verify that the system meets its requirements and is fit for use | Functional testing, integration testing, performance testing, acceptance testing |
| **Deployment** | Make the system available in its target environment | Release, installation, configuration, migration |
| **Production operation** | Operate the system and provide its expected service | Operations, service delivery, administration |
| **Monitoring and support** | Monitor system health and respond to operational issues | Monitoring, alerting, incident management, L1/L2/L3 support |
| **Maintenance and evolution** | Maintain the system and adapt it to changing needs | Bug fixes, patches, upgrades, enhancements |
| **Continuous improvement** | Improve the system, its operation, and its supporting processes | Performance improvements, automation, optimization, process improvements |
| **Retirement** | Safely remove the system from service | Decommissioning, data retention, migration, shutdown |

## [↑][Top] Cross-cutting concerns


| Concern | Purpose | Examples |
| - | - | - |
| **Governance** | Provide decision-making, oversight, accountability, and control throughout the lifecycle | Decisions, approvals, steering, reporting, compliance |
| **Risk management** | Identify, assess, monitor, and mitigate risks throughout the lifecycle | Risk register, mitigation plans, risk reviews |
| **Documentation management** | Ensure that relevant documentation is created, maintained, reviewed, and made accessible | Versioning, reviews, ownership, traceability |
| **Change management** | Control and communicate changes that may affect the project or system | Change requests, impact analysis, approvals |
| **Stakeholder management** | Identify, involve, and communicate with relevant stakeholders | Stakeholder mapping, communication, feedback |




# Principle when writing documentation

Each document may have metadata such as:
* Audience
* Lifecycle stage
* System / project
* Domain
* Document type
* Owner
* Status

When creating document
- A document should have a **single authoritative location**.
- Links, references, indexes, or metadata should make it discoverable from different perspectives. 
- This approach
  - Avoids creating separate copies of the same information for different audiences in different location.
  - Reduce duplication, prevents conflicting versions, and improves traceability across the documentation lifecycle.


For example, **One architecture document**
- → owned by Engineering
- → relevant to Operations
- → reviewed by Governance
- → linked from the corresponding system documentation


# Documentation's organization

- Document should have properties (aka. meta-data).
- Documentation should be organized primarily around the **lifecycle of systems and projects**, while also being classified by **audience**.
- A document may serve multiple audiences and may therefore be relevant to several teams or stakeholders.

## Document properties

Documents could be associated with the following attributes:

| Attribute | Purpose | Example |
|-|-|-|
| **Lifecycle stage** | Identifies the document's position in the system or project lifecycle. | Planning, Requirements, Design, Build, Deployment, Operation, Retirement |
| **Audience** | Identifies who uses or reviews the document. | Architect, Developer, Operations, End user |
| **System / Project** | Identifies the system, service, product, or project concerned. | CRM, Kubernetes Platform, Project Alpha |
| **Domain** | Identifies the relevant business or technical domain. | Security, Networking, Finance, Data |
| **Document type** | Identifies the nature of the document. | Requirement, ADR, Architecture, Runbook, User guide |
| **Owner** | Identifies who is responsible for maintaining the document. | IT Operations, Security Team, Project Manager |
| **Status** | Identifies the document's current state. | Draft, Active, Deprecated, Archived |


## Primary dimension: lifecycle

The documentation should follow the progression of an IT initiative or system through its lifecycle:
1. **organization's Business and user needs**
1. **Requirements**
1. **Architecture and design**
1. **Development and implementation**
1. **Deployment and release**
1. **Operation and support**
1. **Governance and continuous improvement**

This structure provides a natural relationship between documents and makes it easier to understand how information evolves throughout the lifecycle.

## Secondary dimension: audience

Each document should identify its intended audience. An example of audiences classification could include:

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


A document may have more than one audience.

For example, **An architecture document**: 
- → primarily targets engineering teams 
- → is relevant to:
  - operations, 
  - governance, 
  - other stakeholders.



# Example use cases
## Example 01: build a Terminology

This example illustrates how *terms* can be documented using the **controlled classification** defined above.


| Term | Type | Domain | Definition / Description | Notes |
| - | - | - | - | - |
| **ACID** | Acronym | Databases | Properties that define reliable database transactions: **A**tomicity, **C**onsistency, **I**solation, and **D**urability. | Originally defined in the context of database transactions. |
| **KBE** | Acronym | Kubernetes | **K**ubernetes **B**uilding **E**nvironment. | Used to create and manage Kubernetes environments, including security and observability capabilities. |
| **Kubernetes** | Platform | Container orchestration | Platform for deploying, managing, and orchestrating containerized applications. | Provides capabilities such as scheduling, scaling, service discovery, and self-healing. |
| **kind** | Tool | Kubernetes | **K**ubernetes **in** **D**ocker. | Used to create Kubernetes clusters locally, mainly for development and testing. |
| **Observability** | Concept | Operations | Ability to understand a system’s state and behavior from its outputs. | Typically includes metrics, logs, traces, dashboards, and alerts. |
| **Security** | Concept | Cross-cutting | Practices and controls used to protect systems and data from threats and unauthorized access. | Includes access control, privileged access management, secure defaults, vulnerability management, backup, and recovery. |
| **Security** | Concept | Cross-cutting | <li>Allow a system to be 24/7 accessible and resilient... <li>Protect a system by addressing known points of failure...| Includes access control, privileged access management, secure defaults, vulnerability management, backup, and recovery. |




## Example 02: build a document's classification

The following example illustrates how a document can be classified using its **lifecycle stage** and **intended audience**.

| Document | Document Type | Lifecycle | Audience |
| - | - | - | - |
| [Kubernetes][k8s whatis] | Concept | Learn | Engineering |
| [Security][Security whatis] | Concept | Learn | Engineering |
| [What is Linux][linux whatis] | Concept | Learn | Engineering |
| Kubernetes| User Guide | Operation / Use | End User |
| Kubernetes| Architecture | Design | Engineering, Operations, Governance |
| Kubernetes| Runbook | Operation | Operations |
| Kubernetes| Risk Assessment | Governance | Governance, Sponsor |
| Kubernetes| Contribution Guide | Development | Contributor, Engineering |



# [↑][Top] Todo

## Questions around shared terms
Historically, **terms**, are dedicated to one domain and often get **generalized** or **specialized**

### Example 1: `ACID`

**ACID** and relational database
- Actions are **atomic**: done entirely or not at all.  
- System remains **consistent** after any action or failure.  
- Actions are **isolated**: one sequence does not interfere with others.  
- Effects are **durable**: once completed, changes persist or can be safely rolled back.

**ACID** principles can now be applied to **CLI commands, API operations, CICD, and system workflows** that are **backend** by a DB or not.


### Example 2: `CRUD`


CRUD originates from **data persistence and record management** in relational databases, where it describes the **lifecycle of stored entities**.
* **Create**: add a new persistent entity
* **Read**: retrieve or inspect an existing entity (now is inspect, get)
* **Update** — modify, uopdate the state of an entity
* **Delete** — remove an entity from persistence

**CRUD** principles can now be applied or used as a **generic action model** to describe how any **resource or stateful object** can be managed via 
  - **CLI commands**
  - `API` operations
  - `CI/CD`
  -  and **system workflows** that are **backend** by a DB or not.

