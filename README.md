[//]: #(Reference)
[Top]: #
[doc.K8s]:  ./k8s.md
[doc.Security]:  ./security.md
[doc.Linux]:  ./Linux.md


# doc

---

# Purpose

- This Git repository is the main entry point for the organization’s documentation.
- Its purpose is to provide a consistent and structured documentation covering the **full lifecycle of IT initiatives**
- The documentation is organized to serve different audiences involved in the **lifecycle of a system or project**.



# Terminology

## [↑][Top] Controlled Classification

- This classification is intentionally small
- It provides a consistent way to classify terms that are for example acronyms, concepts, tools, technologies, platforms.
- A new kind should only be introduced when an existing kind cannot accurately classify a term.


| Kind | Definition | Example |
| -------------- | ---------------------------------------------------------------------- | ------------------------- |
| **Acronym** | Short form of a term or expression. | ACID, CRUD |
| **Concept** | Abstract idea, principle, or model. | Observability, Resilience |
| **Tool** | Software, application, framework, service. | `kubectl`, `Terraform` |
| **Technology** | technical approach or technology family. | Containers, REST |
| **Platform** | Provide capabilities, services, or an execution environment for other systems. | Kubernetes, AWS. |
| **Standard** | formal specification, rule, convention or practice. | ISO 27001, OpenAPI |
| **Process** | Defined sequence of activities to achieve an objective. | Incident Management |
| **Project** | Temporary initiative with a defined objective, scope and outcome. | Kubernetes Migration |


For example:

| Term | Kind |
| ----------------- | ---------------- |
| **ACID** | Acronym |
| **Observability** | Concept |
| **Kubernetes** | Platform |
| **kind** | Tool |
| **Linux** | Operating System |





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


# Project and System Lifecycles

| lifecycle| stages|
|-|-|
| **Project lifecycle** | Business idea ➔ Project initiation ➔ Project planning ➔ Requirements and scope ➔ Design ➔ Development and implementation ➔ Delivery and transition ➔ Project closure ➔ Lessons learned |
| **System lifecycle** | Business and user needs ➔ Requirements ➔ Business design ➔ Architecture ➔ Technical design ➔ Development ➔ Testing and validation ➔ Deployment ➔ Production operation ➔ Monitoring and support ➔ Maintenance and evolution ➔ Continuous improvement ➔ Retirement |


## Stages for a Project lifecycle

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

## Stages for a System lifecycle

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

# Cross-cutting concerns


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


For example:**One architecture document**
- → owned by Engineering
- → relevant to Operations
- → reviewed by Governance
- → linked from the corresponding system documentation


# Documentation Organization

- Documentation should be organized primarily around the **lifecycle of systems and projects**, while also being classified by **audience**.
- A document may serve multiple audiences and may therefore be relevant to several teams or stakeholders.

## Primary dimension: lifecycle

The documentation should follow the progression of an IT initiative or system through its lifecycle:
1. **Business and user needs**
1. **Requirements**
1. **Architecture and design**
1. **Development and implementation**
1. **Deployment and release**
1. **Operation and support**
1. **Governance and continuous improvement**

This structure provides a natural relationship between documents and makes it easier to understand how information evolves throughout the lifecycle.

## Secondary dimension: audience

Each document should identify its intended audience. Typical audiences include:

* **End users**
* **Business users**
* **Engineering and development teams**
* **IT operations teams**
* **Governance and stakeholders**
* **Contributors and sponsors**
* **Corporate / internal services**

A document may have more than one audience.

For example:**An architecture document may** 
- primarily target engineering teams 
- also being relevant to 
  - operations, 
  - governance, 
  - other stakeholders.

## Document classification

Where practical, each document should be associated with the following attributes:

| Attribute | Purpose |
| -------------------- | --------------------------------------------------------------------------------------------------------------- |
| **Lifecycle stage** | Identifies where the document belongs in the system or project lifecycle. |
| **Audience** | Identifies who is expected to use or review the document. |
| **System / Project** | Identifies the system, service, product, or project concerned. |
| **Domain** | Identifies the business or technical domain concerned. |
| **Document type** | Identifies the nature of the document, such as requirement, ADR, architecture document, runbook, or user guide. |
| **Owner** | Identifies the person or team responsible for maintaining the document. |
| **Status** | Identifies the current state of the document, such as draft, active, deprecated, or archived. |







# Example Use cases
## Example 01: Terminology Catalogue

This example illustrates how terms can be documented using the controlled classification defined above.


| Term | Type | Domain | Definition / Description | Notes |
| - | - | - | - | - |
| **ACID** | Acronym | Databases | Properties that define reliable database transactions: **A**tomicity, **C**onsistency, **I**solation, and **D**urability. | Originally defined in the context of database transactions. |
| **KBE** | Acronym | Kubernetes | **K**ubernetes **B**uilding **E**nvironment. | Used to create and manage Kubernetes environments, including security and observability capabilities. |
| **Kubernetes** | Platform | Container orchestration | Platform for deploying, managing, and orchestrating containerized applications. | Provides capabilities such as scheduling, scaling, service discovery, and self-healing. |
| **kind** | Tool | Kubernetes | **K**ubernetes **in** **D**ocker. | Used to create Kubernetes clusters locally, mainly for development and testing. |
| **Observability** | Concept | Operations | Ability to understand a system’s state and behavior from its outputs. | Typically includes metrics, logs, traces, dashboards, and alerts. |
| **Security** | Concept | Cross-cutting | Practices and controls used to protect systems and data from threats and unauthorized access. | Includes access control, privileged access management, secure defaults, vulnerability management, backup, and recovery. |
| **Security** | Concept | Cross-cutting | <li>Allow a system to be 24/7 accessible and resilient... <li>Protect a system by addressing known points of failure...| Includes access control, privileged access management, secure defaults, vulnerability management, backup, and recovery. |

|name|name type|parent domain|extension/description|comment
|-|-|-|-|-|
|acid|acro||**A**tomic, **C**onsistent, **I**solated, **D**urable|historically a concept of relational DB
|kbe|acro||**K**u**b**ernetes **E**asy|<br>**create** K8s cluster on demand<br>**secure** ak8s cluster<br>make an existing k8s cluster **observable**|
|kubernetes|Platform||manages containerized app| Self healing 
|kind|acro||**K**ubernetes **In** **D**ocker|**create** kind cluster on demand|
|observability|concept||Understand a system state from its outputs|Includes metrics, logs, dashboard, alert|
|security|concept||Allow a system to be 24/7 accessible and resilient by addressing known points of failure|Includes access controls, root access, backups recovery, protection against attacks, bugs reolution, CVE updates, ...|
|security|concept||Protect a system by addressing known points of failure|Includes access controls, root access management, safe defaults, backups, recovery procedures, and protection against attacks|


Each stage may produce documentation that is relevant to one or more audiences. The repository therefore provides a common place to discover, maintain, and relate documentation across these stages.


## Example 02:  Audience Classification

This example illustrates how documentation can be classified according to its intended audience.


| Audience | Description | Typical Documentation |
| --------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| **End User** | Person who uses a system or service to perform daily activities. | User manuals, user procedures, FAQs |
| **Business** | Person or group concerned with business needs, processes, and outcomes. | Business requirements, process documentation, project overview |
| **Engineering** | Team responsible for designing, developing, and implementing systems. | Requirements, architecture documentation, design specifications, development guides |
| **Operations** | Team responsible for deploying, operating, monitoring, and supporting systems. | Operational documentation, deployment guides, runbooks, incident procedures |
| **Governance** | Person or group responsible for oversight, compliance, risk, and decision-making. | Decision records, compliance documentation, risk documentation, governance records |
| **Contributor** | Person who creates, maintains, or contributes to documentation, systems, or projects. | Contribution guides, documentation standards, development guidelines |
| **Sponsor** | Person or organization providing strategic support, funding, or organizational ownership. | Project overview, funding documentation, governance documentation |
| **Corporate / Internal Services** | Internal service responsible for supporting organizational activities. | Service documentation, user procedures, support documentation |


Documentation by Audience
  - is designed to cover any audiences **involved** in the **lifecycle** of any IT **projects** in the organization.
  - is designed for 
    - business users
    - development teams
    - operations teams
    - governance stakeholders
  - aims to document from 
    - business idea to end-user needs
    - end-user needs to business design
    - business design to needed resources (system requirements, technical design, ...)
    - resource and/or system requirements and design to development and implementation
    - development and implementation to production operations and support
    - production operations and support to governance loopback


## Example 03:  Document Classification

The following example illustrates how a document can be classified using its **lifecycle stage** and **intended audience**.

| Document | Lifecycle | Audience |
| --------------------------------- | --------------------- | ----------------------------------- |
| **Kubernetes User Guide** | Operation / Use | End User |
| **Kubernetes Architecture** | Design | Engineering, Operations, Governance |
| **Kubernetes Runbook** | Operation | Operations |
| **Kubernetes Risk Assessment** | Governance | Governance, Sponsor |
| **Kubernetes Contribution Guide** | Development | Contributor, Engineering |


## [↑][Top] Example 04
|name|name type|parent domain|extension/description|comment
|-|-|-|-|-|
|Kubernets|Concept|||[Whatis][doc.K8s]
|Security|Concept|||[Whatis][doc.Security]
|Linux|Os|||[Whatis][doc.Linux]


## [↑][Top] Example 05: Documentation by audience

The documentation may include the following types of content:

| Audience | Documentation scope / deliverables |
| - | - |
| **End Users** | User manuals<br>User procedures<br>Support and service documentation<br>**L1 support** |
| **IT Operations** | **Operational documentation**<br>Deployment guides and runbooks<br>Monitoring, backup, recovery, and incident procedures<br>**L2 support** |
| **IT Engineering** | **Requirements** — functional and technical<br>**Architecture documentation** — logical and technical<br>Design specifications<br>**L3 support** |
| **Governance / Stakeholders** | Project overviews<br>Decision records<br>Compliance and risk documentation |
| **Cross-cutting / Reference** | **Definitions and controlled vocabulary**<br>Standards, conventions, and guidelines |
| **Contributors / Sponsors** | Contribution guides<br>Decision records<br>Funding and governance documentation |
| **Corporate / Internal Services** | User manuals<br>User procedures<br>Support and service documentation<br>**L1 support** |


The documentation may include

|**Audience**|**Documentation Scope / Deliverables**|
|-|-|
|**End Users**|User manuals<br>User procedures<br>Support & service documentation <br>**L1** support |
|**IT – Operations** (prod) |**Operational documentation**<br>Deployment guides & runbooks<br>Monitoring, backup & incident procedures <br>**L2** support|
|**IT – Engineering** (Dev) |**Requirements** (functional & technical)<br>**Architecture documentation** (logical & technical)<br>Design specifications <br>**L3** support|
|**Governance / Stakeholders**|Project overview<br>Decision records<br>Compliance & risk documentation|
|**Cross-cutting / Reference**|**Definitions** & controlled vocabulary<br>Standards, conventions & guidelines|
|**Contributors / Sponsors** |Project contribution guides<br>Decision records<br>Funding and governance documentation |
|**Corporate Services/ Business**|User manuals<br>User procedures<br>Support & service documentation — L1|








----

# [↑][Top] Todo
## Questions around documentation
**how to organize the documentation**
- around kind of users, readers, stakeholders

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

