[//]: #(Home)
[home]: ../README.md


[←][home]

<h1 align="center">Documentation Standard Improvement</h1>



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




### ** By Audience (Who reads it?)**
| Artifact | Audience |
|----------|----------|
| What is a Resource? | 🧑‍💼 **Stakeholder** |
| What is Managing? | 🧑‍💼 **Stakeholder** |
| What is CLI? | 👨‍💻 **Developer** |
| Roadmap | 🧑‍💼 **Stakeholder** |
| Architecture | 👨‍💻 **Developer** |


### **By Lifecycle Phase (When is it used?)**
| Artifact | Phase |
|----------|-------|
| What is a Resource? | 📖 **Onboarding** |
| What is Managing? | 📖 **Onboarding** |
| What is CLI? | 📖 **Onboarding** |
| Roadmap | 🗓️ **Planning** |
| Architecture | 🏗️ **Design** |


### **By Document Type (What is it?)**
| Artifact | Type |
|----------|------|
| What is a Resource? | 📘 **Glossary** |
| What is Managing? | 📘 **Glossary** |
| What is CLI? | 📘 **Glossary** |
| Roadmap | 🗺️ **Plan** |
| Architecture | 🏛️ **Specification** |


### **By Purpose (What does it do?)**
| Artifact | Purpose |
|----------|---------|
| What is a Resource? | 📚 **Educate** |
| What is Managing? | 📚 **Educate** |
| What is CLI? | 📚 **Educate** |
| Roadmap | 📊 **Communicate** |
| Architecture | 📐 **Design** |


### **Recommended: The "2-Axis" System**

| Artifact | What | Who | When |
|----------|------|-----|------|
| What is a Resource? | Glossary | Everyone | Onboarding |
| What is Managing? | Glossary | Everyone | Onboarding |
| What is CLI? | Glossary | Developers | Onboarding |
| Roadmap | Plan | Stakeholders | Planning |
| Architecture | Spec | Developers | Design |


### **My Suggestion for You**

Since your documents are mostly **explanatory/educational**, use:

| Artifact | Category | Audience |
|----------|----------|----------|
| [What is a Resource?][res-whatis] | 📘 Glossary | All |
| [What is Managing?][manage-whatis] | 📘 Glossary | All |
| [What is CLI?][cli-whatis] | 📘 Glossary | Devs |
| [Roadmap][roadmap-whatis] | 🗺️ Plan | Stakeholders |
| [Architecture][arch-whatis] | 🏛️ Design | Devs |


**What problem are you actually trying to solve with the "Kind" column?**
- Group documents for navigation?
- Assign owners?
- Filter by audience?
- Track document status?

Tell me your use case and I'll give you the **perfect classification system**!