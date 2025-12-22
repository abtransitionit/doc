[//]: #(Reference)
[doc.K8s]:  ./k8s.md
[doc.Security]:  ./security.md
[doc.Linux]:  ./Linux.md


# doc
This Git **repository** is both the **entry point** and the **source of truth** for the documentation of the organization’s resources.


# Documentation by Audience
The documentation is designed to cover any audiences **involved** in the **lifecycle** of any IT **projects** in the organization.

The documentation is designed for 
  - business users
  - development teams
  - operations teams
  - governance stakeholders

The documentation aims to document
  - from business idea to end-user needs
  - from end-user needs to business design
  - from business design to needed resources (system requirements, technical design, ...)
  - from resource and/or system requirements and design to development and implementation
  - from development and implementation to production operations and support
  - from production operations and support to governance loopback

The documentation include

|**Audience**|**Documentation Scope / Deliverables**|
|-|-|
|**End Users**|User manuals<br>User procedures<br>Support & service documentation <br>**L1** support  |
|**IT – Operations** (prod)   |**Operational documentation**<br>Deployment guides & runbooks<br>Monitoring, backup & incident procedures <br>**L2** support|
|**IT – Engineering** (Dev)   |**Requirements** (functional & technical)<br>**Architecture documentation** (logical & technical)<br>Design specifications <br>**L3** support|
|**Governance / Stakeholders**|Project overview<br>Decision records<br>Compliance & risk documentation|
|**Cross-cutting / Reference**|**Definitions** & controlled vocabulary<br>Standards, conventions & guidelines|
|**Contributors / Sponsors**  |Project contribution guides<br>Decision records<br>Funding and governance documentation                                        |
|**Corporate Services/ Business**|User manuals<br>User procedures<br>Support & service documentation — L1|






# Example
An example of a table that document **names/concepts/topics/projects**. This table can be spit in any convenient way, to adapt to the audience.

|name|name type|parent domain|extension/description|comment
|-|-|-|-|-|
|acid|acro||**A**tomic, **C**onsistent, **I**solated, **D**urable|historically a concept of relational DB
|kbe|acro||**K**u**b**ernetes **E**asy|<br>**create** K8s cluster on demand<br>**secure** ak8s cluster<br>make an existing k8s cluster **observable**|
|kubernetes|Tool|
|kind|acro||**K**ubernetes **In** **D**ocker|**create** kind cluster on demand|
|observability|concept||Understand a system state from its outputs|Includes metrics, logs, dashboard, alert|
|security|concept||Allow a system to be 24/7 accessible and resilient by addressing known points of failure|Includes access controls, root access, backups recovery, protection against attacks, bugs reolution, CVE updates, ...|
|security|concept||Protect a system by addressing known points of failure|Includes access controls, root access management, safe defaults, backups, recovery procedures, and protection against attacks|

# Full Example
|name|name type|parent domain|extension/description|comment
|-|-|-|-|-|
|Kubernets|Concept|||[Whatis][doc.K8s]
|Security|Concept|||[Whatis][doc.Security]
|Linux|Os|||[Whatis][doc.Linux]





# Terminology (English ↔ French)

This table provides **reference translations for commonly used IT documentation terms** on this page, and a short explanations to ensure a shared understanding across audiences. 



Here is the same table, **only reordered by the “English Term” column (A–Z)**, with **no other changes**:

| **English Term**           | **French Equivalent**       | **Notes / Usage**                                                                                                           |
| -------------------------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Architecture documentation | Dossier d’architecture      | Logical and technical architecture                                                                                          |
| Architecture documentation | Dossier d’architecture      | Description of system structure, components, and interactions                                                               |
| Controlled vocabulary      | Vocabulaire contrôlé        | Shared and standardized terms                                                                                               |
| Controlled vocabulary      | Vocabulaire contrôlé        | Standardized set of terms used across documentation                                                                         |
| Corporate Services         | Service interne             | services provided within the organization to support its internal operations, not services delivered to external customers. |
| Decision record            | Registre de décisions (ADR) | Architecture / project decisions                                                                                            |
| Decision record (ADR)      | Registre de décisions       | Traceable record of important technical or architectural decisions                                                          |
| Deployment guide           | Guide de déploiement        | Install, upgrade, rollback                                                                                                  |
| Deployment guide           | Guide de déploiement        | Procedures for installing, upgrading, or rolling back a system                                                              |
| Design specification       | Spécification de conception | Detailed technical design                                                                                                   |
| End User                   | Utilisateur final           | Person who uses the application in daily operations                                                                         |
| Governance                 | Gouvernance                 | Decision-making, oversight, and control of the system                                                                       |
| Operational documentation  | Documents d’exploitation    | Production, run, and support                                                                                                |
| Operational documentation  | Documents d’exploitation    | Documentation required to run and support the system in production                                                          |
| Requirements               | Exigences / Besoins         | Often split into *functional* and *technical*                                                                               |
| Requirements               | Exigences / Besoins         | Functional or technical needs the system must satisfy                                                                       |
| Runbook                    | Procédure opérationnelle    | Step-by-step operational actions                                                                                            |
| Runbook                    | Procédure opérationnelle    | Step-by-step instructions for operational tasks                                                                             |
| Stakeholder                | Partie prenante             | Any person or entity with an interest in the system (business, sponsor, regulator, etc.)                                    |



# Todo
## Questions around documentation
**how to organize the documentation**
- around type of users, readers, stakeholders

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

