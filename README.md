# doc
This Git **repository** is both the **entry point** and the **source of truth** for the documentation of the organization’s resources.


# Documentation by Audience
The documentation is designed to cover any audiences **involved** in the **lifecycle** of any IT **projects** in the organization including business users, development teams, operations teams, and governance stakeholders:
  - from business idea to end-user needs
  - from end-user needs to business design
  - from business design to system requirements and technical design
  - from system requirements and design to development and implementation
  - from development and implementation to production operations and support
  - from production operations and support to governance loopback

The documentation include

|**Audience**|**Documentation Scope / Deliverables**|
|-|-|
|**End Users**|User manuals<br>User procedures<br>Support & service documentation <br>**L1** support   |
|**IT – Operations** (prod)    |**Operational documentation**<br>Deployment guides & runbooks<br>Monitoring, backup & incident procedures <br>**L2** support|
|**IT – Engineering** (Dev)    |**Requirements** (functional & technical)<br>**Architecture documentation** (logical & technical)<br>Design specifications <br>**L3** support|
|**Governance / Stakeholders** |Project overview<br>Decision records<br>Compliance & risk documentation |
|**Cross-cutting / Reference** |**Definitions** & controlled vocabulary<br>Standards, conventions & guidelines|
| **Contributors / Sponsors**   | Project contribution guides<br>Decision records<br>Funding and governance documentation                                         |
|**Corporate Services/ Business**| User manuals<br>User procedures<br>Support & service documentation — L1 |


## Terminology (English ↔ French)

This table provides **reference translations for commonly used IT documentation terms** on this page, and a short explanations to ensure a shared understanding across audiences. 



|**English Term**     |**French Equivalent** |**Notes / Usage**     |
|-------------------------- |--------------------------- |--------------------------------------------- |
|Requirements   |Exigences / Besoins   |Often split into *functional* and *technical* |
|Architecture documentation |Dossier d’architecture|Logical and technical architecture|
|Operational documentation  |Documents d’exploitation    |Production, run, and support|
|Runbook  |Procédure opérationnelle    |Step-by-step operational actions  |
|Deployment guide     |Guide de déploiement  |Install, upgrade, rollback  |
|Design specification |Spécification de conception |Detailed technical design   |
|Decision record|Registre de décisions (ADR) |Architecture / project decisions  |
|Controlled vocabulary|Vocabulaire contrôlé  |Shared and standardized terms     |
|Stakeholder    |Partie prenante    |Any person or entity with an interest in the system (business, sponsor, regulator, etc.) |
|Governance     |Gouvernance  |Decision-making, oversight, and control of the system|
|End User |Utilisateur final  |Person who uses the application in daily operations  |
|Requirements   |Exigences / Besoins|Functional or technical needs the system must satisfy|
|Architecture documentation |Dossier d’architecture   |Description of system structure, components, and interactions    |
|Operational documentation  |Documents d’exploitation |Documentation required to run and support the system in production     |
|Runbook  |Procédure opérationnelle |Step-by-step instructions for operational tasks|
|Deployment guide     |Guide de déploiement     |Procedures for installing, upgrading, or rolling back a system   |
|Decision record (ADR)|Registre de décisions    |Traceable record of important technical or architectural decisions     |
|Controlled vocabulary|Vocabulaire contrôlé     |Standardized set of terms used across documentation  |
|Corporate Services|Service interne|services provided within the organization to support its internal operations, not services delivered to external customers.






# Example
## Example of projects

|name|type|extension/description|comment
|-|-|-|-|
|kbe|acro|**K**u**b**ernetes **E**asy|<br>**create** K8s cluster on demand<br>**secure** ak8s cluster<br>make an existing k8s cluster **observable**|
|kind|acro|**K**ubernetes **In** **D**ocker|**create** kind cluster on demand|


## Example of definitions and concepts
|name|type|extension/description|comment
|-|-|-|-|
|acid|acro|**A**tomic, **C**onsistent, **I**solated, **D**urable| relatiobnal DB concept
| observability | concept | Understand a system state from its outputs | Includes metrics, logs, dashboard, alert |
| security | concept | Allow a system to be 24/7 accessible and resilient by addressing known points of failure | Includes access controls, root access, backups recovery, protection against attacks, bugs reolution, CVE updates, ...|
| security | concept | Protect a system by addressing known points of failure | Includes access controls, root access management, safe defaults, backups, recovery procedures, and protection against attacks |

**ACID**
- Actions are **atomic**: done entirely or not at all.  
- System remains **consistent** after any action or failure.  
- Actions are **isolated**: one sequence does not interfere with others.  
- Effects are **durable**: once completed, changes persist or can be safely rolled back.
- **ACID** principles can be applied to **CLI commands, API operations, and system workflows**.


